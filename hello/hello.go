package hello

import (
	"fmt"

	"github.com/hashicorp/terraform/version"
	"github.com/terraform-providers/terraform-provider-aws/aws"
	"github.com/terraform-providers/terraform-provider-template/template"
)

func dumpProvider() {
	fmt.Printf("%#v", aws.Provider())
}

func main() {
	fmt.Printf(`
Welcome! You are using the following packages:-

hashicorp/terraform %s
terraform-providers/terraform-provider-aws
terraform-providers/terraform-provider-template
`, version.VersionString())
}
