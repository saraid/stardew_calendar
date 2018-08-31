# stardew_calendar
Ruby tool for planning a farm in Stardew Valley

There is a live API-ified thing running on Heroku.

## API

* /can_be_planted_today
  * Required Parameter: `season` (Valid: `spring`, `summer`, `fall`, `winter`)
  * Require either `day` or `remaining_days`: Must be between 1 and 28.
    * Use `day` to specify a day, or `remaining_days` to specify the number of days until the season changes.

```
curl 'https://stardew-calendar.herokuapp.com/can_be_planted_today?season=summer&day=20' | jq .
{
  "Hot Pepper": 5,
  "Poppy": 7,
  "Radish": 6,
  "Summer Spangle": 8,
  "Sunflower": 8,
  "Wheat": 4
}
```

```
curl 'https://stardew-calendar.herokuapp.com/can_be_planted_today?season=summer&remaining_days=8' | jq .
{
  "Hot Pepper": 5,
  "Poppy": 7,
  "Radish": 6,
  "Summer Spangle": 8,
  "Sunflower": 8,
  "Wheat": 4
}
```

* /harvest_schedule
  * Method: POST
  * Payload Shape:
```json
{ "schedule": [
  { "action": "plant", "crop": "Blueberry", "day": "Summer 1" },
  { "action": "clear", "day": "Summer 20" }
]}
```

```
curl -XPOST --data-binary '{ "schedule": [
>   { "action": "plant", "crop": "Blueberry", "day": "Summer 1" },
>   { "action": "clear", "day": "Summer 20" }
> ]}' 'https://stardew-calendar.herokuapp.com/harvest_schedule' | jq .
{
  "Spring 1": [
    "SeasonChange"
  ],
  "Summer 1": [
    "SeasonChange",
    "Plant Blueberry"
  ],
  "Summer 2": [
    "Grow"
  ],
  "Summer 3": [
    "Grow"
  ],
  "Summer 4": [
    "Grow"
  ],
  "Summer 5": [
    "Grow"
  ],
  "Summer 6": [
    "Grow"
  ],
  "Summer 7": [
    "Grow"
  ],
  "Summer 8": [
    "Grow"
  ],
  "Summer 9": [
    "Grow"
  ],
  "Summer 10": [
    "Grow"
  ],
  "Summer 11": [
    "Grow"
  ],
  "Summer 12": [
    "Grow"
  ],
  "Summer 13": [
    "Grow"
  ],
  "Summer 14": [
    "Harvest Blueberry"
  ],
  "Summer 15": [
    "Grow"
  ],
  "Summer 16": [
    "Grow"
  ],
  "Summer 17": [
    "Grow"
  ],
  "Summer 18": [
    "Grow",
    "Harvest Blueberry"
  ],
  "Summer 19": [
    "Grow"
  ],
  "Summer 20": [
    "Clear"
  ],
  "Fall 1": [
    "SeasonChange"
  ]
}
```
