# French Republican iCalendar
## An iCalendar (.ics) file that displays the date and rural day name according to the [French Republican calendar](https://en.wikipedia.org/wiki/French_Republican_calendar)

This repository includes iCalendar (.ics) files of the French Republican calendar for the years 2022, 2023, 2024, and 2025, and the MATLAB script used to make them.

The ics files can be loaded onto an Outlook or Google calendar. They will appear as calendar events for each day, marked as free with no reminders (similar to other holiday calendars).

Each day will display the current date according to the French Republican calendar and the corresponding rural day name.

## Loading the calendar
### Outlook
Go to File->Open & Export->Open Calendar and choose the appropriate .ics file. 

You can then choose to "Open as new" or "Import". 

"Open as new" will create a new calendar which can be opened next to your own. It's also easier to delete this calendar if you are no longer interested.

"Import" will import all calendar events (all days of the year) to your own calendar. I am not aware of an easy way to delete all events from your calendar afterwards.

Also note that Outlook displays an error while importing, but it doesn't seem to cause any issues.

### Google Calendar
Next to "Other calendars" click the + button and choose "From URL". Enter any of the following URLs and click "Add calendar":
- 2022: `https://raw.githubusercontent.com/davkat1/FrenchRepublicaniCalendar/main/FrenchRepublicanCalnedar_01012022-31122022.ics`
- 2023: `https://raw.githubusercontent.com/davkat1/FrenchRepublicaniCalendar/main/FrenchRepublicanCalnedar_01012023-31122023.ics`
- 2024: `https://raw.githubusercontent.com/davkat1/FrenchRepublicaniCalendar/main/FrenchRepublicanCalnedar_01012024-31122024.ics`
- 2025: `https://raw.githubusercontent.com/davkat1/FrenchRepublicaniCalendar/main/FrenchRepublicanCalnedar_01012025-31122025.ics`


## Files in this repository
### French Republican iCalendar files
These can be simply downloaded and installed as explained above.

- 2022: `FrenchRepublicanCalnedar_01012022-31122022.ics`
- 2023: `FrenchRepublicanCalnedar_01012023-31122023.ics`
- 2024: `FrenchRepublicanCalnedar_01012024-31122024.ics`
- 2025: `FrenchRepublicanCalnedar_01012025-31122025.ics`

### Files used to generate the iCalendar files
#### MATLAB files
- `greg2rep.m`: Convert a Gregorian date (given as a `datetime` object) to a French Republican date (given as a `string`)
- `createFrenchRepublicaniCalendar.m`: Create a French Republican iCalendar file for a given date span
- `createCalendars2022to2025.m`: The script used to generate the iCalendar files above
#### CSV files
- `ruralDayNames.csv`: a list of the rural day names in English, following the [translation
in Wikipedia](https://en.wikipedia.org/wiki/French_Republican_calendar#Rural_calendar), as it appeared on 19 Thermidor 230 (August 6, 2022).
- `frenchRepublicanMonths.csv`: the months of the French Republican calendar and an English translation.
### Other files
`socialPreview.jpg` taken from [Wikipedia](https://en.wikipedia.org/wiki/French_Republican_calendar#/media/File:Flor%C3%A9al_commence_le_21_avril.jpg).
## Date conversion
Conversion from Greogrian to Republican dates follows the Equinox method for the years 1-15 of the Republic (1792-1805). From year 15 on, the Romme method is used. For further explanation, see [Wikipedia](https://en.wikipedia.org/wiki/French_Republican_calendar#Converting_from_the_Gregorian_Calendar)   (accessed 19 Thermidor 230 (August 6, 2022)).

## More information
From [Wikipedia](https://en.wikipedia.org/wiki/French_Republican_calendar): 

> The **French Republican calendar** (_calendrier républicain français_), also commonly called the **French Revolutionary calendar** (_calendrier révolutionnaire français_), was a calendar created and implemented during the French Revolution and used by the French government for about 12 years from late 1793 to 1805, and for 18 days by the Paris Commune in 1871.
> 
> The revolutionary system was designed in part to remove all religious and royalist influences from the calendar, and was part of a larger attempt at decimalisation in France (which also included decimal time of day, decimalisation of currency, and metrication). It was used in government records in France and other areas under French rule, including Belgium, Luxembourg, and parts of the Netherlands, Germany, Switzerland, Malta, and Italy. 
> 
> To reduce the influence of the Church, Fabre d'Églantine introduced a Rural Calendar in which each day of the year had a unique name associated with the rural economy, stated to correspond to the time of year. Every décadi (day ending in 0) was named after an agricultural tool. Each quintidi (day ending in 5) was named for a common animal. The rest of the days were named for "grain, pasture, trees, roots, flowers, fruits" and other plants, except for the first month of winter, Nivôse, during which the rest of the days were named after minerals.
> 
> Five extra days – six in leap years – were national holidays at the end of every year.

## Author
David Katzin, david.katzin1@gmail.com, https://twitter.com/realDavidKatzin

Created on Thermidor 230 (August 2022).
