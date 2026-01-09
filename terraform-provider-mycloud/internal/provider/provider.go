package provider

import (
	"context"

	"github.com/hashicorp/terraform-plugin-framework/datasource"
	"github.com/hashicorp/terraform-plugin-framework/provider"
	"github.com/hashicorp/terraform-plugin-framework/provider/schema"
	"github.com/hashicorp/terraform-plugin-framework/resource"
	"github.com/hashicorp/terraform-plugin-framework/types"
)

type MyCloudProvider struct{}

type MyCloudProviderModel struct {
	Endpoint types.String `tfsdk:"endpoint"`
}

func New() provider.Provider {
	return &MyCloudProvider{}
}

func (p *MyCloudProvider) Metadata(ctx context.Context, req provider.MetadataRequest, resp *provider.MetadataResponse) {
	resp.TypeName = "mycloud"
}

func (p *MyCloudProvider) Schema(ctx context.Context, req provider.SchemaRequest, resp *provider.SchemaResponse) {
	resp.Schema = schema.Schema{
		Attributes: map[string]schema.Attribute{
			"endpoint": schema.StringAttribute{
				Required:    true,
				Description: "URL нашего Node.js API (например, http://localhost:3000)",
			},
		},
	}
}

func (p *MyCloudProvider) Configure(ctx context.Context, req provider.ConfigureRequest, resp *provider.ConfigureResponse) {
	var data MyCloudProviderModel

	resp.Diagnostics.Append(req.Config.Get(ctx, &data)...)
	if resp.Diagnostics.HasError() {
		return
	}

	resp.ResourceData = data.Endpoint.ValueString()
}

func (p *MyCloudProvider) DataSources(ctx context.Context) []func() datasource.DataSource {
	return nil
}

func (p *MyCloudProvider) Resources(ctx context.Context) []func() resource.Resource {
	return []func() resource.Resource{
		NewProjectResource,
	}
}
