# GCP-GPU-Jupyter

Using Terraform to launch coursera-aml-docker: https://github.com/Cheukting/coursera-aml-docker to Google Cloud Platform, which allows a quick set up of using GPU to complete assignmanets for Coursera "Advanced Machine Learning" specialization: https://www.coursera.org/specializations/aml

**please be aware that using GPU on GCP is not free and you need to apply for quota (which may take a day or 2) before you have access to it**

## To install Terraform:
https://www.terraform.io/intro/getting-started/install.html

## Before you launch, you need to have :
- Terraform installed
- An Google Could Plaform Account
- Quota of GPU on GCP: https://cloud.google.com/compute/quotas
- An SSH key setup for your project: `Compute Engine -> Metadata -> SSH Keys`
- Service Account Key file in the same directry of the .tf file:
  `Google Cloud Platform -> API Manager -> Credentials -> Create Credentials -> Service account key`.
  For the Key type field chose JSON. Put the downloaded file right were your Terraform config file is and name it `login-details.json`.

## Launching:
1. Go to the directory containing the .tf file
2. Start Terraform project: `terraform init`
3. Check the configuration: `terraform plan`
4. Launch: `terraform apply` then answer `yes`
5. Find the IP address assigned: `terraform show | grep assigned_nat_ip`
6. Go to browser (I test it on Chrome) and type in the IP address (use http)

## More information is given at the slide:
https://www.slideshare.net/CheukTingHo/launch-jupyter-to-the-cloud-speaking-at-gdg-cloud-london

## Also check out details on using GPU on Google Cloud Platform:
https://cloud.google.com/compute/docs/gpus/add-gpus