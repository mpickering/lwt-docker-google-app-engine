# Deploy LWT to Google App Engine

These scripts provide the simplest way to deploy your own personal
[Learning With Texts](http://lwt.sf.net) instance to Google App Engine so you can access your texts
anywhere.

## Usage

Firstly modify `config.example` and save it was `config`.

* `LWT_PROJECT` is the name you want to access your instance on.
* `LWT_USERNAME` is the username you want to use to login
* `LWT_PASSWORD` is the password you want to use to login
* `LWT_MYSQL_PASSWORD` is the password you want to root user of the MySQL database to have.
* `GCLOUD_BILLING_ACCOUNT` is the billing account ID you want to link the project to. You can find this out by running `gcloud beta billing accounts list`

Make sure that `gcloud` and `envsubst` are on your `PATH`.

Then run `./init` to initialise the project, cloud SQL database and deploy
the application. That's it!

If you make any changes to the application and want to redeploy you can use
the `./deploy` script.

Once the script finishes running you can access your instance on `$LWT_PROJECT.appspot.com/lwt/`.
For example, if I had called the project `matts-french-lwt` then the URL would be `matts-french-lwt.appspot.com/lwt/`.
