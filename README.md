## Create an vm image with docker support

00. Export your credentials.

        $ export AWS_DEFAULT_REGION=eu-west-1
        $ export AWS_ACCESS_KEY_ID=XXXXXXXXXX
        $ export AWS_SECRET_ACCESS_KEY=YYYYYY

        $ export DIGITALOCEAN_API_KEY=AAAAAAA
        $ export DIGITALOCEAN_CLIENT_ID=BBBBB

00. Create a key-pair.

        $ ssh-keygen -f keys/id_docker

00. Install the needed tools.

        $ pip install awscli
        $ gem install tugboat

00. "Authorize" the tools.

        $ tugboat authorize
        $ aws ec2 import-key-pair --key-name docker \
          --public-key-material file://keys/id_docker.pub

00. Build the images.

        $ packer build image.json

## Start the vm image

    $ vagrant up --provider=aws

  or

    $ vagrant up --provider=digital_ocean
