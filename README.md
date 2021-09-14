# Nested Resource Routing Lab

## Learning Goals

- Create nested routes
- Use params in nested routes

## Introduction

In this lab, we'll continue working on a cooking recipes API, and
build out some nested routes to give users easier access to our data.

```txt
Recipe -< Ingredient
```

Get the lab set up by running:

```console
$ bundle install
$ rails db:migrate db:seed
```

There is seed data in place so you can test your solution out in Postman. You
can also run `learn test` to run the tests.

## Instructions

You will need to handle the requests listed below and return the appropriate
JSON data in the response.

**Note:** watch out for [Rails' `DoubleRenderError`][double render error] as you
work. The error is fairly straightforward: Rails only allows `render` to be
called once in an action. We have seen one way to avoid this error: by using
conditional code to ensure that only one `render` executes. A second way to
avoid the error is to include an explicit `return`, eg: `return render json: ...` to keep any later `render` statements from executing.

[double render error]: https://api.rubyonrails.org/classes/AbstractController/DoubleRenderError.html

### Nested Ingredient Index Route

This route should show all ingredients for one individual recipe.

```txt
GET /recipes/:recipe_id/ingredients

Response Body
-------
[
  {
    "id": 1,
    "name": "Rolled Oats",
    "quantity": "1/3 cup",
    "recipe_id": 1
  },
  {
    "id": 2,
    "name": "Maple Syrup",
    "quantity": "1 tablespoon",
    "recipe_id": 1
  }
]
```

### Nested Ingredient Show Route

This route should show one ingredient matching the `:id` from the URL.

```txt
GET /recipes/:recipe_id/ingredients/:id

Response Body
-------
{
  "id": 1,
  "name": "Rolled Oats",
  "quantity": "1/3 cup",
  "recipe_id": 1
}
```

### Nested Ingredient Create Route

This route should create a new ingredient that belongs to a recipe.

```txt
POST /recipes/:recipe_id/ingredients

Headers:
-------
Content-Type: application/json

Request Body:
-------
{
  "name": "Maple Syrup",
  "quantity": "1 tablespoon",
}

Response Body:
-------
{
  "id": 2,
  "name": "Maple Syrup",
  "quantity": "1 tablespoon",
  "recipe_id": 1
}
```

## Resources

- [Routing: Nested Resources](https://guides.rubyonrails.org/routing.html#nested-resources)
