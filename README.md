# realMethods - DevOps Project Generator v.1.2

Use realMethods to generate DevOps project for both new application and app refactoring scenarios.

Save time and get started with all the code and configuration you need but don't want to have to write.

Generation includes
- all tech stack specific source code (UI, MVC, Serverless, Persistence, Caching, etc...)
- build file
- auto commit to your Git repository
- YAML configuration for all major CI/CD platforms (Jenkins, CircleCI, Codeship, AWS Codepipelines, Azure Pipelines, Bitbucket pipelines, Gitlab pipelines, and others)
- optional Docker image creation
- Terraform files for infrastructure provision, including Kubernetes

## Getting Started

These instructions will cover usage information and for the realMethods docker image.

### Prerequisites

In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

### Pull the Docker image

Before using the realMethods image, it has to first be pulled by issuing the following command:

```
docker pull realmethods/realmethods:latest
```

### Usage

#### Run as Default

To run the image with its defaults, issue the following command:
``
docker run -it -d -p 8080:8080 realmethods/realmethods:latest

```

#### Run with data storage to a local volume

To run the image using a local volume on the hosting server, issue the following command:

```
docker run -it -d -p 8080:8080 -v /usr/realmethods-data:/realmethods-data realmethods/realmethods:latest
```

Directory /usr/realmethods-data must exist for this command to execute successfully.

#### Run using a specific MySQL instance

By default, the image with run against a remote MySQL-8 instance hosted by realMethods.  This will give you access to all the
publicly available tech stacks and models.  Likewise, it will expose all your publicly defined tech stacks and models to the community.

If you would like to store data to a separate MySQL-8 instance, you need to provide the connection parameters to the instance.

```
docker run -it -d -p 8080:8080
-e DATABASE_URL=THE-MYSQL-URL
-e DATABASE_USERNAME=THE-MYSQL-USER-NAME
-e DATABASE_PW=THE-MYSQL-PASSWORD
realmethods/realmethods:latest
```

#### Optional Environment Variables

Only required when connecting to a separate MySQL-8 instance.

* `DATABASE_URL` - URL where the MySQL instance is located.  Likely of the form http://xxx.xxx.xxx:3306
* `DATABASE_USERNAME` - User name with read/write privileges
* `DATABASE_PW` - Password for the user name

#### Volumes

* `/user/realmethods-data` - Optional location on the hosting server where application data will be written to.

#### Access The Installation via Web Browser</h3>
The application should be running and accessible on the exposed port. For example:

```http://xxx.xxx.xxx.xxx:8080```

where xxx.xxx.xxx.xxx is the IP address to the host server of the application.

You can Register a new User account or login using the default credentials of <i>admin</i> and <i>letmin2</i> as the userId and password respectively.


#### Access the Running Instance of realMethods in the Container

You might have a need to access the running instance inside the container.  It involves 2 steps:

```docker ps```

Issuing this command will give show you the container id.  Next,
 
## Contributing

We are always interested in supporting new tech stacks.  If you are an expert in something (whether popular or obscure) and want to capture it as a reusable technology$

## License

This project is licensed under the MIT License.

## Acknowledgments

* A huge thanks to all the clients over the years that have helped to refine and battle test the platform into what it is today.


