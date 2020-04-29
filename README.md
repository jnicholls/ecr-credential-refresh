# ecr-credentials-refresh

This Chart creates a CronJob (and an initial Job) to regularly refresh Docker credentials
to access AWS ECR for a specified AWS account and region. The Docker credentials are stored
into a specified `docker-registry` Secret for use with `imagePullSecrets`. It can be installed
into multiple namespaces to provide an accessible `imagePullSecrets` for each desired namespace.

## Configuration Values

#### `awsCredentialsSecret`
Name of a Kubernetes Secret that has three fields:

* `accessKeyId` - AWS IAM Access Key ID
* `secretAccessKey` - AWS IAM Secret Access Key
* `region` - Target AWS Region

This Secret is mounted and its values used to authenticate with AWS ECR and retrieve a Docker login.
It must be available within the same namespace that this Chart is installed.
Defaults to `"ecr-aws-credentials"`.

#### `dockerCredentialsSecret`
Name of a Kubernetes Secret that this chart will create to store the Docker login credentials.
The Secret will be created in the same namespace in which this chart is installed.
If this Secret already exists, it will be overwritten in its entirety.
Defaults to `"ecr-docker-credentials"`.

#### `refreshSchedule`
The cron schedule on which credentials will regularly be refreshed. Defaults to `"0 * * * *"`, i.e. on the hour every hour.

## Dockerfile

The `Dockerfile` produces the container image that has the dependencies needed to execute the refresh job. The container
is simple and is currently hosted publicly on Docker Hub at [`jarrednicholls/aws-cli-kubectl`](https://hub.docker.com/r/jarrednicholls/aws-cli-kubectl).
