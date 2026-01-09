package provider

import (
	"bytes"
	"context"
	"encoding/json"
	"net/http"

	"github.com/hashicorp/terraform-plugin-framework/resource"
	"github.com/hashicorp/terraform-plugin-framework/resource/schema"
	"github.com/hashicorp/terraform-plugin-framework/resource/schema/planmodifier"
	"github.com/hashicorp/terraform-plugin-framework/resource/schema/stringplanmodifier"
	"github.com/hashicorp/terraform-plugin-framework/types"
)

type ProjectResource struct {
	endpoint string
}

type ProjectResourceModel struct {
	ID          types.String `tfsdk:"id"`
	Name        types.String `tfsdk:"name"`
	Description types.String `tfsdk:"description"`
	Status      types.String `tfsdk:"status"`
}

func NewProjectResource() resource.Resource {
	return &ProjectResource{}
}

func (r *ProjectResource) Metadata(ctx context.Context, req resource.MetadataRequest, resp *resource.MetadataResponse) {
	resp.TypeName = req.ProviderTypeName + "_project"
}

func (r *ProjectResource) Schema(ctx context.Context, req resource.SchemaRequest, resp *resource.SchemaResponse) {
	resp.Schema = schema.Schema{
		Attributes: map[string]schema.Attribute{
			"id": schema.StringAttribute{
				Computed: true,
				PlanModifiers: []planmodifier.String{
					stringplanmodifier.UseStateForUnknown(),
				},
			},
			"name":        schema.StringAttribute{Required: true},
			"description": schema.StringAttribute{Optional: true},
			"status":      schema.StringAttribute{Computed: true},
		},
	}
}

func (r *ProjectResource) Configure(ctx context.Context, req resource.ConfigureRequest, resp *resource.ConfigureResponse) {
	if req.ProviderData == nil {
		return
	}
	r.endpoint = req.ProviderData.(string)
}

// CREATE: POST /projects
func (r *ProjectResource) Create(ctx context.Context, req resource.CreateRequest, resp *resource.CreateResponse) {
	var data ProjectResourceModel
	resp.Diagnostics.Append(req.Plan.Get(ctx, &data)...)

	body, _ := json.Marshal(map[string]string{
		"name":        data.Name.ValueString(),
		"description": data.Description.ValueString(),
	})

	hReq, _ := http.NewRequestWithContext(ctx, "POST", r.endpoint+"/projects", bytes.NewBuffer(body))
	hReq.Header.Set("Content-Type", "application/json")
	
	client := &http.Client{}
	hResp, err := client.Do(hReq)
	if err != nil {
		resp.Diagnostics.AddError("API Error", err.Error())
		return
	}
	defer hResp.Body.Close()

	var result map[string]interface{}
	json.NewDecoder(hResp.Body).Decode(&result)

	data.ID = types.StringValue(result["id"].(string))
	data.Status = types.StringValue(result["status"].(string))

	resp.Diagnostics.Append(resp.State.Set(ctx, &data)...)
}

// READ: GET /projects/:id
func (r *ProjectResource) Read(ctx context.Context, req resource.ReadRequest, resp *resource.ReadResponse) {
	var data ProjectResourceModel
	resp.Diagnostics.Append(req.State.Get(ctx, &data)...)

	hReq, _ := http.NewRequestWithContext(ctx, "GET", r.endpoint+"/projects/"+data.ID.ValueString(), nil)
	client := &http.Client{}
	hResp, _ := client.Do(hReq)
    
	if hResp.StatusCode == http.StatusNotFound {
		resp.State.RemoveResource(ctx)
		return
	}

	var result map[string]interface{}
	json.NewDecoder(hResp.Body).Decode(&result)

	data.Name = types.StringValue(result["name"].(string))
	data.Description = types.StringValue(result["description"].(string))
	data.Status = types.StringValue(result["status"].(string))

	resp.Diagnostics.Append(resp.State.Set(ctx, &data)...)
}

// UPDATE: PUT /projects/:id
func (r *ProjectResource) Update(ctx context.Context, req resource.UpdateRequest, resp *resource.UpdateResponse) {
	var data ProjectResourceModel
	resp.Diagnostics.Append(req.Plan.Get(ctx, &data)...)

	body, _ := json.Marshal(map[string]string{
		"name":        data.Name.ValueString(),
		"description": data.Description.ValueString(),
	})

	hReq, _ := http.NewRequestWithContext(ctx, "PUT", r.endpoint+"/projects/"+data.ID.ValueString(), bytes.NewBuffer(body))
	hReq.Header.Set("Content-Type", "application/json")
	
	client := &http.Client{}
	client.Do(hReq)

	resp.Diagnostics.Append(resp.State.Set(ctx, &data)...)
}

// DELETE: DELETE /projects/:id
func (r *ProjectResource) Delete(ctx context.Context, req resource.DeleteRequest, resp *resource.DeleteResponse) {
	var data ProjectResourceModel
	resp.Diagnostics.Append(req.State.Get(ctx, &data)...)

	hReq, _ := http.NewRequestWithContext(ctx, "DELETE", r.endpoint+"/projects/"+data.ID.ValueString(), nil)
	client := &http.Client{}
	client.Do(hReq)
}