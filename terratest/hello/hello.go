package hello

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func main() {
	fmt.Printf("You are using %s", terraform.RunTerraformCommand(&testing.T{}, &terraform.Options{}, "version"))
}
