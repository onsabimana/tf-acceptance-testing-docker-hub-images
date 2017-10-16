package main

import (
	"fmt"
	"log"
	"os"
	"testing"

	"github.com/hashicorp/terraform/helper/resource"
	"github.com/hashicorp/terraform/helper/schema"
	"github.com/hashicorp/terraform/terraform"

	// eventually the cozero fork should die when
	// https://github.com/terraform-providers/terraform-provider-aws/pull/1463
	// gets merged replace with
	// provider "github.com/terraform-providers/terraform-provider-aws/aws"
	provider "github.com/cozero/terraform-provider-aws/aws"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/awserr"
	"github.com/aws/aws-sdk-go/service/iam"

	"github.com/terraform-providers/terraform-provider-template/template"
	"github.com/terraform-providers/terraform-provider-tls/tls"
)

func main() {
	fmt.Println("Hello world")
}
