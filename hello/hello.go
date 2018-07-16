package hello

import (
	"fmt"

	_ "github.com/cozero/terraform-provider-buildkite/buildkite"
	"github.com/hashicorp/terraform/version"
	_ "github.com/terraform-providers/terraform-provider-archive/archive"
	_ "github.com/terraform-providers/terraform-provider-aws/aws"
	_ "github.com/terraform-providers/terraform-provider-github/github"
	_ "github.com/terraform-providers/terraform-provider-grafana/grafana"
	_ "github.com/terraform-providers/terraform-provider-pagerduty/pagerduty"
	_ "github.com/terraform-providers/terraform-provider-random/random"
	_ "github.com/terraform-providers/terraform-provider-template/template"
)

func main() {
	fmt.Printf(`
Welcome! You are using the following packages:-

hashicorp/terraform %s
cozero/terraform-provider-buildkite
terraform-providers/terraform-provider-archive
terraform-providers/terraform-provider-aws
terraform-providers/terraform-provider-grafana
terraform-providers/terraform-provider-github
terraform-providers/terraform-provider-pagerduty
terraform-providers/terraform-provider-random
terraform-providers/terraform-provider-template
`, version.String())
}
