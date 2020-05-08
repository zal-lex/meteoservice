*NOTE: this project taught me to use third-party API and to write tests with RSPEC*

# Meteoservice forecast

This console program produce you 24 hours weater forecast in the selected city.
It uses data from XML API meteoservice.ru.

## Source of cities

The cities for the forecast are represented in the `CITIES` constant in file:

```
/meteoservice.rb
```

If you want to change this list, you should find `id` of interested city there:

```
meteoservice.ru/content/export
```

## Install and launch the program

It is very simple to use: just clone repo and run the command:

```
ruby meteoservice.rb
```

*The application requires Ruby version 2.4.0 or higher*
