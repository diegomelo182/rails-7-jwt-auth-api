# JWT Auth API Example

Here I want to share a JWT Auth Rest API with you

Below I will show the **master.key** file content, and yes I know that we never can share this, but as this project do not will be in production I will share it with you all guys.

**config/master.key (d8e69fa08807a6b75d01af19af3b5dec)**

## Run the migrations and the Seed

```BASH
$ rails db:create db:migrate db:seed
```

The seed creates a default user and password, follow the data below:

```
email: 'example@example.com'
password: 'example@example.com'
```
 Now you can use this on `[POST] /v1/auth/sign_in` endpoint.

## Run Rails

```BASH
$ rails server
```

## Endpoints

**Auth**

`[POST] /v1/auth/sign_in`

Payload:
```JSON
{
  "login": "your-email-here",
  "password": "your-password-here"
}
```
Returns:
```JSON
{
  "is_valid": true
}
```

`[POST] /v1/auth/renew`

Payload:
```JSON
{
  "token": "your-token-here"
}
```
Returns:
```JSON
{
  "is_valid": true
}
```

`[POST] /v1/auth/valid`

Payload
```JSON
{
  "token": "your-token-here"
}
```
Returns:
```JSON
{
  "is_valid": true
}
```

There is a **Rails Scaffold** called **User** that can only be accessed with a valid token on **Athorization header**.
