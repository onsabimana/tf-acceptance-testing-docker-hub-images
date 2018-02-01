package hello

import (
	"fmt"

	"github.com/hashicorp/terraform/version"
	_ "github.com/terraform-providers/terraform-provider-aws/aws"
	_ "github.com/terraform-providers/terraform-provider-pagerduty/pagerduty"
	_ "github.com/terraform-providers/terraform-provider-template/template"
)

func main() {
	fmt.Printf(`
Welcome! You are using the following packages:-

hashicorp/terraform %s
terraform-providers/terraform-provider-aws
terraform-providers/terraform-provider-pagerduty
terraform-providers/terraform-provider-template
`, version.String())
}
