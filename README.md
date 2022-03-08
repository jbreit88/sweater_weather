![White with Colorful Circle Abstract Logo](https://user-images.githubusercontent.com/88853324/156896066-14e6c3f7-e323-4e0e-b5bc-11975ae5a162.png)

# Mod3 Solo Project: Sweater Weather

reference: [Project Specs and Overview](https://backend.turing.edu/module3/projects/sweater_weather/)

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#set-up">Set Up</a></li>
        <li><a href="#versions">Versions</a></li>
        <li><a href="#gems">Important Gems</a></li>
        <li><a href="#use-of-this-repository">Use of this Repository</a>
          <ul>
            <li>Frontend Server</li>
            <li>Backend Server</li>
          </ul>
        </li>
    </li>
    </ul>
    <li>
      <a href="#project-description">About This Project</a>
      <ul>
        <li><a href="#learning-goals-for-project">Learning Goals for Project</a></li>
      </ul>
    </li>
    <li>
      <a href="#apis">Book Club API</a>
      <details>
        <summary>Available Endpoints</summary>
        <ul>
          <li><a href="#backgrounds-endpoints">Backgrounds Endpoints</a></li>
          <li><a href="#book-search-endpoints">Book Search Endpoints</a></li>
          <li><a href="#forecast-endpoints">Forecast Endpoints</a></li>
          <li><a href="#road-trip-endpoints">Road Trip Endpoints</a></li>
          <li><a href="#sessions-endpoints">Sessions Endpoints</a></li>
          <li><a href="#users-endpoints">Users Endpoints</a></li>
        </ul>
      </details>
    </li>
    <li><a href="#collaborators">Collaborators</a></li>
  </ol>
</details>

----------

## Getting Started

### Versions

- Ruby 2.7.2
- Rails 5.2.6

----------

### Gems

- Testing: [rspec-rails](https://github.com/rspec/rspec-rails), [simplecov](https://github.com/simplecov-ruby/simplecov), [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails), [faker](https://github.com/vajradog/faker-rails), [webmock](https://github.com/bblimke/webmock), [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)

- API: [jsonapi-serializer](https://github.com/fotinakis/jsonapi-serializers), [figaro](https://medium.com/@MinimalGhost/the-figaro-gem-an-easier-way-to-securely-configure-rails-applications-c6f963b7e993), [faraday](https://github.com/lostisland/faraday)

- User Authentication: [bcrypt](https://github.com/bcrypt-ruby/bcrypt-ruby)

----------

### Set Up
On your local system, open a terminal session to run the following commands:
1. Clone this repository `$ git clone git@github.com:jbreit88/sweater_weather.git`
2. Navigate to the newly cloned directory `$ cd sweater_weather`
3. If bundler is not installed run `$ gem install bundler`
4. If or after bundler is installed run `$ bundle install` to install the required Gems
5. If errors occur, check for proper installation and versions of `bundler`, `ruby`, and `rails`
6. Set up the database locally with `$ rails db:{:drop,:create,:migrate,:seed}`
7. Open your text editor and check to see that `schema.rb` exists
8. You may also run the RSpec test suite locally with the command `$ bundle exec rspec` to ensure everything is functioning as expected.

----------

## Project Description

This is a back-end project designed to explore the consumption and combination of data from multiple APIs in order to expose new functionality to a front-end team.

## Learning Goals for Project:

Explicit
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Research, select, and consume an API based on your needs as a developer

Implicit
- Project planning
- Reading/Writing documentation
- Time Management/Prioritizing Work
- Break down large project goals into manageable steps
- GitHub workflow and project management tools

----------

## APIs
Available endpoints (See the [Postman Collection](https://www.getpostman.com/collections/4eed83f8f6f286f882a0))

###  Backgrounds endpoints

| http verb | name | description | example |
| --- | --- | --- | --- |
| GET | /backgrounds | Returns information to call an image based on keyword search | /api/v1/backgrounds?location={{city,state}} |

Data sourced from the [UnSplash Image API](https://unsplash.com/documentation)

<details>
    <summary> JSON response example </summary>

Single image by keyword:
```json
  {
    "data": {
        "type": "image",
        "id": null,
        "attributes": {
            "image": {
                "image_id": "zSm5JPgNeuc",
                "description": "woman in white tank top sitting on brown wooden chair",
                "url": "https://images.unsplash.com/photo-1629163330223-c183571735a1?crop=entropy&cs=srgb&fm=jpg&ixid=MnwzMDc5Mjh8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3xlbnwwfHx8fDE2NDY3NjE1NTA&ixlib=rb-1.2.1&q=85"
            },
            "credit": {
                "original_website": "https://unsplash.com",
                "photographer": "Taylor Daugherty",
                "photographer_profile": "https://unsplash.com/@tayloradaugherty"
            }
        }
    }
}

```

</details>


### Book Search endpoints

| http verb | name | description | example |
| --- | --- | --- | --- |
| GET | /book-search | Returns data for a specified number of books related to the keyword search. | /api/v1/book-search?location={{query_string}}&quantity={{integer}} |

Data sourced from the [Open Library API](https://openlibrary.org/developers/api)

<details>
  <summary> JSON response examples </summary>

Book information:
```json
{
    "data": {
        "id": null,
        "type": "books",
        "attributes": {
            "destination": "denver,co",
            "forecast": {
                "summary": "clear sky",
                "temperature": "36.9 F"
            },
            "total_books_found": 41867,
            "books": [
                {
                    "isbn": [
                        "9780762507849",
                        "0762507845"
                    ],
                    "title": "Denver, Co",
                    "publisher": [
                        "Universal Map Enterprises"
                    ]
                },
                {
                    "isbn": [
                        "0883183668",
                        "9780883183663"
                    ],
                    "title": "Photovoltaic safety, Denver, CO, 1988",
                    "publisher": [
                        "American Institute of Physics"
                    ]
                }
            ]
        }
    }
}

```

</details>


### Forecast endpoints

| http verb | name | description | example |
| --- | --- | --- | --- |
| GET | /forecast | String | Returns data for the current/daily/hourly weather at a specified location. | /api/v1/forecast?location={{city,state}} |

Data sourced from the [Open Weather API](https://openweathermap.org/api)
<details>
  <summary> JSON response examples </summary>

Forecast:
```json
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "data": {
                    "datetime": "2022-03-08T12:17:49.000-07:00",
                    "sunrise": "2022-03-08T06:22:28.000-07:00",
                    "sunset": "2022-03-08T17:59:10.000-07:00",
                    "temp": 36.03,
                    "feels_like": 32.74,
                    "humidity": 29,
                    "uvi": 3.95,
                    "visibility": 10000,
                    "conditions": "clear sky",
                    "icon": "01d"
                }
            },
            "hourly_weather": {
                "data": [
                    {
                        "time": "12:00:00",
                        "temp": 36.03,
                        "conditions": "clear sky",
                        "icon": "01d"
                    },
                    {
                        "time": "13:00:00",
                        "temp": 35.6,
                        "conditions": "clear sky",
                        "icon": "01d"
                    },
                    {
                        "time": "14:00:00",
                        "temp": 35.58,
                        "conditions": "clear sky",
                        "icon": "01d"
                    },
                    {
                        "time": "15:00:00",
                        "temp": 35.69,
                        "conditions": "clear sky",
                        "icon": "01d"
                    },
                    {
                        "time": "16:00:00",
                        "temp": 35.55,
                        "conditions": "clear sky",
                        "icon": "01d"
                    },
                    {
                        "time": "17:00:00",
                        "temp": 34.07,
                        "conditions": "clear sky",
                        "icon": "01d"
                    },
                    {
                        "time": "18:00:00",
                        "temp": 31.26,
                        "conditions": "clear sky",
                        "icon": "01n"
                    },
                    {
                        "time": "19:00:00",
                        "temp": 30.36,
                        "conditions": "clear sky",
                        "icon": "01n"
                    }
                ]
            },
            "daily_weather": {
                "data": [
                    {
                        "date": "2022-03-08",
                        "sunrise": "2022-03-08T06:22:28.000-07:00",
                        "sunset": "2022-03-08T17:59:10.000-07:00",
                        "max_temp": 36.03,
                        "min_temp": 20.25,
                        "conditions": "clear sky",
                        "icon": "01d"
                    },
                    {
                        "date": "2022-03-09",
                        "sunrise": "2022-03-09T06:20:54.000-07:00",
                        "sunset": "2022-03-09T18:00:13.000-07:00",
                        "max_temp": 28.31,
                        "min_temp": 16.97,
                        "conditions": "light snow",
                        "icon": "13d"
                    },
                    {
                        "date": "2022-03-10",
                        "sunrise": "2022-03-10T06:19:20.000-07:00",
                        "sunset": "2022-03-10T18:01:16.000-07:00",
                        "max_temp": 24.75,
                        "min_temp": 14.38,
                        "conditions": "snow",
                        "icon": "13d"
                    },
                    {
                        "date": "2022-03-11",
                        "sunrise": "2022-03-11T06:17:45.000-07:00",
                        "sunset": "2022-03-11T18:02:18.000-07:00",
                        "max_temp": 33.84,
                        "min_temp": 14.29,
                        "conditions": "clear sky",
                        "icon": "01d"
                    },
                    {
                        "date": "2022-03-12",
                        "sunrise": "2022-03-12T06:16:09.000-07:00",
                        "sunset": "2022-03-12T18:03:20.000-07:00",
                        "max_temp": 53.56,
                        "min_temp": 27.77,
                        "conditions": "clear sky",
                        "icon": "01d"
                    }
                ]
            }
        }
    }
}
```

</details>

### Road Trip endpoints
__Users of the road trip endpoints must provide an API key in the body of their request.__ For information on how to obtain a key, please see the <a href="#users-endpoints">users endpoints</a> section below.

| http verb | name | description | example |
| --- | --- | --- | --- |
| POST | /road_trip | Returns information about road trip time and weather at destination location at time of arrival | /api/v1/road_trip |

<details>
  <summary> JSON request body and response examples </summary>

Road Trip Request Body:
```json
  {
    "origin": "Denver,CO",
    "destination": "Pueblo,CO",
    "api_key": "4c68dedc001ebef636be637a61fbcac7"
  }
```
  
Road Trip Response:
```json
{
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "Denver,CO",
            "end_city": "Pueblo,CO",
            "travel_time": "01 hours, 45 minutes",
            "weather_at_eta": {
                "temperature": 38.53,
                "conditions": "clear sky"
            }
        }
    }
}
```

</details>


### Sessions endpoints

| http verb | name | data type | description | example |
| --- | --- | --- | --- | --- |
| POST | /sessions | String | Logs a registered user in. | /api/v1/sessions |

<details>
  <summary> JSON request body and response examples </summary>

Login User Request Body:
```json
  {
    "email": "whatever@example.com",
    "password": "password"
  }
```
  
Login User Response:
```json
{
    "data": {
        "id": 1,
        "type": "users",
        "attributes": {
            "email": "whatever@example.com",
            "api_keys": "4c68dedc001ebef636be637a61fbcac7"
        }
    }
}
```
</details>

### Users endpoints

| http verb | name | data type | description | example |
| --- | --- | --- | --- | --- |
| POST | /users | String | Registers a new user. Requires a unique email. | /api/v1/users |

<details>
  <summary> JSON request body and response examples </summary>

Register User Request Body:
```json
  {
    "email": "whaver@example.com",
    "password": "password",
    "password_confirmation": "password"
  }
```
  
Register User Response:
```json
{
    "data": {
        "id": 2,
        "type": "users",
        "attributes": {
            "email": "whatever@example.com",
            "api_keys": {{api key generated on user registration}}
        }
    }
}
```
</details>

----------

## Collaborators

([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <!-- Brad -->
     <td align="center"><a href="https://github.com/jbreit88"><img src="https://avatars.githubusercontent.com/u/88853324?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Brad (he/him)</b></sub></a><br /><a href="https://github.com/jbreit88/sweater_weather/commits?author=jbreit88" title="Code">💻</a> <a href="#ideas-jbreit88" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/jbreit88/sweater_weather/commits?author=jbreit88" title="Tests">⚠️</a> <a href="https://github.com/jbreit88/sweater_weather/pulls?q=is%3Apr+reviewed-by%3Ajbreit88" title="Reviewed Pull Requests">👀</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification.
<!--
