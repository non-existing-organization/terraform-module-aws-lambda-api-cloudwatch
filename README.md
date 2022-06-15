[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![GPL3 License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]
[![Ask Me Anything][ask-me-anything]][personal-page]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/stiliajohny/terraform-module-aws-lambda-api-cloudwatch">
    <img src="https://github.com/stiliajohny/terraform-module-aws-lambda-api-cloudwatch/raw/master/.assets/logo.png" alt="master Logo" width="80" height="80">
  </a>

  <h3 align="center">terraform-module-aws-lambda-api-cloudwatch</h3>

  <p align="center">
    Easy Deploy Lambda, API and Cloudwatch
    <br />
    <a href="./README.md"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/stiliajohny/terraform-module-aws-lambda-api-cloudwatch/issues/new?labels=i%3A+bug&template=1-bug-report.md">Report Bug</a>
    ·
    <a href="https://github.com/stiliajohny/terraform-module-aws-lambda-api-cloudwatch/issues/new?labels=i%3A+enhancement&template=2-feature-request.md">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->

## Table of Contents

- [Table of Contents](#table-of-contents)
- [About The Project](#about-the-project)
  - [Built With](#built-with)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules)
- [Resources](#resources)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Costs](#costs-with-infracost)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgements](#acknowledgements)

<!-- ABOUT THE PROJECT -->

## About The Project

<img src="https://github.com/stiliajohny/terraform-module-aws-lambda-api-cloudwatch/raw/master/.assets/screenshot.svg" class="center" alt="AWS draw.io image" >




The main purpose of this terraform module is to deploy an easy Lambda function with API trigger and Cloudwatch logging for both Lambda and API Getway.

### Built With

- Terraform
- AWS
  - Lambda
  - Cloudwatch
  - API Gateway

---

<!-- GETTING STARTED -->

## Getting Started

### Prerequisites

- None

### Installation

```terraform
module "example" {
  source               = "git::https://github.com/stiliajohny/terraform-module-aws-lambda-api-cloudwatch.git?ref=master"
  lambda_app_name      = "example_name"
  lambda_filename      = "example_code.py"
  api_gw_route_key     = "$default"
  lambda_handler       = "my_code_method.lambda_handler"
}

```

## Usage

<details>
  <summary>Terraform-docs Output</summary>

## Requirements

No requirements.

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_archive"></a> [archive](#provider_archive) | 2.2.0   |
| <a name="provider_aws"></a> [aws](#provider_aws)             | 3.70.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                        | Type        |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_apigatewayv2_api.my-slack_event_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api)                 | resource    |
| [aws_apigatewayv2_integration.my-slack_event_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_integration) | resource    |
| [aws_apigatewayv2_route.my-slack_event_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_route)             | resource    |
| [aws_apigatewayv2_stage.my-slack_event_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage)             | resource    |
| [aws_cloudwatch_log_group.my-slack_event_handler_api_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group)  | resource    |
| [aws_cloudwatch_log_group.my-slack_event_handler_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group)  | resource    |
| [aws_iam_role_policy_attachment.lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)      | resource    |
| [aws_lambda_function.my-slack_event_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)                   | resource    |
| [aws_lambda_permission.my-slack_event_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission)               | resource    |
| [archive_file.zip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file)                                                 | data source |
| [aws_iam_role.iam_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role)                                      | data source |

## Inputs

| Name                                                                                                                     | Description                                                                                                                                                         | Type          | Default                                                 | Required |
| ------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ------------------------------------------------------- | :------: |
| <a name="input_api_gw_integration_methode"></a> [api_gw_integration_methode](#input_api_gw_integration_methode)          | The integration methode for the API Gateway.                                                                                                                        | `string`      | `"POST"`                                                |    no    |
| <a name="input_api_gw_integration_type"></a> [api_gw_integration_type](#input_api_gw_integration_type)                   | The integration type for the API Gateway.                                                                                                                           | `string`      | `"AWS_PROXY"`                                           |    no    |
| <a name="input_api_gw_protocol_type"></a> [api_gw_protocol_type](#input_api_gw_protocol_type)                            | The protocol type for the API Gateway.                                                                                                                              | `string`      | `"HTTP"`                                                |    no    |
| <a name="input_api_gw_route_key"></a> [api_gw_route_key](#input_api_gw_route_key)                                        | The route key for the route. For HTTP APIs, the route key can be either `$default`, or a combination of an HTTP method and resource path, for example, `GET /pets`. | `string`      | `"$default"`                                            |    no    |
| <a name="input_aws_region"></a> [aws_region](#input_aws_region)                                                          | The AWS region to create things in.                                                                                                                                 | `string`      | `"us-east-1"`                                           |    no    |
| <a name="input_cloudwatch_log_retention_days"></a> [cloudwatch_log_retention_days](#input_cloudwatch_log_retention_days) | The number of days to retain logs in CloudWatch.                                                                                                                    | `number`      | `14`                                                    |    no    |
| <a name="input_lambda_app_description"></a> [lambda_app_description](#input_lambda_app_description)                      | The description of the Lambda function.                                                                                                                             | `string`      | `"A simple Lambda function that says hello."`           |    no    |
| <a name="input_lambda_app_name"></a> [lambda_app_name](#input_lambda_app_name)                                           | The name of the Lambda function.                                                                                                                                    | `string`      | n/a                                                     |   yes    |
| <a name="input_lambda_architecture"></a> [lambda_architecture](#input_lambda_architecture)                               | The architecture of the lambda function                                                                                                                             | `list(any)`   | <pre>[<br> "x86_64"<br>]</pre>                          |    no    |
| <a name="input_lambda_env_variables"></a> [lambda_env_variables](#input_lambda_env_variables)                            | The environment variables to pass to the Lambda function.                                                                                                           | `map(string)` | <pre>{<br> "variable_name": "variable_value"<br>}</pre> |    no    |
| <a name="input_lambda_filename"></a> [lambda_filename](#input_lambda_filename)                                           | The name of the Lambda function's file.                                                                                                                             | `string`      | n/a                                                     |   yes    |
| <a name="input_lambda_handler"></a> [lambda_handler](#input_lambda_handler)                                              | The name of the Lambda function's handler.                                                                                                                          | `string`      | n/a                                                     |   yes    |
| <a name="input_lambda_memory_size"></a> [lambda_memory_size](#input_lambda_memory_size)                                  | The amount of memory to allocate to the lambda function                                                                                                             | `number`      | `128`                                                   |    no    |
| <a name="input_lambda_runtime"></a> [lambda_runtime](#input_lambda_runtime)                                              | The runtime to use for the Lambda function.                                                                                                                         | `string`      | `"python3.9"`                                           |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                            | (Optional) A mapping of tags to assign to the bucket.                                                                                                               | `map(any)`    | `{}`                                                    |    no    |

## Outputs

| Name                                                                                            | Description                                     |
| ----------------------------------------------------------------------------------------------- | ----------------------------------------------- |
| <a name="output_api_base_url"></a> [api_base_url](#output_api_base_url)                         | Base URL for API Gateway stage.                 |
| <a name="output_iam_for_lamda"></a> [iam_for_lamda](#output_iam_for_lamda)                      | The name of the savings_plan_utilization budget |
| <a name="output_lambda_function_name"></a> [lambda_function_name](#output_lambda_function_name) | Name of the Lambda function.                    |

</details>


## Costs

You can use the tool [infracost](https://www.infracost.io/) to see an estimate how much the deployment of resources might cost depending on the usage.

The tool can be installed via this [doc](https://www.infracost.io/docs/#1-install-infracost)

After that you can issue the command:

```bash
infracost.exe breakdown --path . --show-skipped
```


## Roadmap

See the [open issues](https://github.com/stiliajohny/terraform-module-aws-lambda-api-cloudwatch/issues) for a list of proposed features (and known issues).

---

<!-- CONTRIBUTING -->

## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

<!-- LICENSE -->

## License

Distributed under the GPLv3 License. See `LICENSE` for more information.

<!-- CONTACT -->

## Contact

John Stilia - stilia.johny@gmail.com

<!--
Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)
-->

---

<!-- ACKNOWLEDGEMENTS -->

## Acknowledgements

- [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
- [Img Shields](https://shields.io)
- [Choose an Open Source License](https://choosealicense.com)
- [GitHub Pages](https://pages.github.com)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/stiliajohny/terraform-module-aws-lambda-api-cloudwatch.svg?style=for-the-badge
[contributors-url]: https://github.com/stiliajohny/terraform-module-aws-lambda-api-cloudwatch/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/stiliajohny/terraform-module-aws-lambda-api-cloudwatch.svg?style=for-the-badge
[forks-url]: https://github.com/stiliajohny/terraform-module-aws-lambda-api-cloudwatch/network/members
[stars-shield]: https://img.shields.io/github/stars/stiliajohny/terraform-module-aws-lambda-api-cloudwatch.svg?style=for-the-badge
[stars-url]: https://github.com/stiliajohny/terraform-module-aws-lambda-api-cloudwatch/stargazers
[issues-shield]: https://img.shields.io/github/issues/stiliajohny/terraform-module-aws-lambda-api-cloudwatch.svg?style=for-the-badge
[issues-url]: https://github.com/stiliajohny/terraform-module-aws-lambda-api-cloudwatch/issues
[license-shield]: https://img.shields.io/github/license/stiliajohny/terraform-module-aws-lambda-api-cloudwatch?style=for-the-badge
[license-url]: https://github.com/stiliajohny/terraform-module-aws-lambda-api-cloudwatch/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/johnstilia/
[product-screenshot]: .assets/screenshot.png
[ask-me-anything]: https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg?style=for-the-badge
[personal-page]: https://github.com/stiliajohny
