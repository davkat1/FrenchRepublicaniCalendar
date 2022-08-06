function outString = greg2rep(gregDate)
% Convert a Gregorian date to a French Republican date.
%
% Usage:
%   outString = greg2rep(gregDate);
% Input:
%   gregDate        A date in the Greogrian calendar, given as a datetime object
% Output:
%   outString       A string representing the given date in the French
%                   Republican calendar, in the format:
%                   <day of month> <month> <year>; <rural day name>
%
%  The rural day name is given in English, following the translation
%  in Wikipedia, https://en.wikipedia.org/wiki/French_Republican_calendar#Rural_calendar
%  as it appeared on 19 Thermidor 230 (August 6, 2022).
%  The month name is given in French, with a translation to English on
%  the 1st of each month.
%  The complementary days are given in French with an English translation.
%
% Conversion from Greogrian to Republican dates is done according to the
% Equinox method for the years 1-15 of the Republic (1792-1805). From year
% 15 on, the Romme method is used. For further explanation, see
% https://en.wikipedia.org/wiki/French_Republican_calendar#Converting_from_the_Gregorian_Calendar
% (accessed 19 Thermidor 230 (August 6, 2022)).
%
% Dates before initiation of the calendar (22-09-1792) return NaN.

% Created by David Katzin, Thermidor 230 (August 2022)
% david.katzin1@gmail.com
% https://github.com/davkat1/FrenchRepublicaniCalendar
    
    %% Calculate the difference between the input day and first day of Republican calendar
    repCalendarFirstDay = datetime('22-09-1792','InputFormat','dd-MM-yyyy');
    daysSinceFirstDay = days(gregDate-repCalendarFirstDay);
    
    if daysSinceFirstDay<0
        outString = NaN;
        return;
    end

    %% Leap year calculation. 
    % Follows the equinox method during the years of the Republic, 
    % and the Romme method afterwards
    isRepLeapYear = @(year) ...
        (year==3 || year==7 || year==11) || ( year>14  && ...
        mod(year,4) == 0 && ~(mod(year,100)==0 && mod(year,400)~=0));

    daysInRepYear = @(year) 365+isRepLeapYear(year);
    
    %% Find the Republican year of the given date 
    dayCount = 0;
    repYear = 1; % Republican year at the given date
    firstDayOfYear = repCalendarFirstDay; % Greogrian date of 1 Vendemiaire in repYear

    while (dayCount + daysInRepYear(repYear))<=daysSinceFirstDay
        dayCount = dayCount + daysInRepYear(repYear);
        firstDayOfYear = firstDayOfYear + daysInRepYear(repYear);
        repYear = repYear + 1;
    end
    
    %% Find the Republican date
    repDayOfYear = days(gregDate-firstDayOfYear)+1; % Republican day of year
    repMonth = floor((repDayOfYear-1)/30)+1; % Republican month
    repDayOfMonth = mod(repDayOfYear, 30); 
    repDayOfMonth(repDayOfMonth==0) = 30; % Republican day of month

    %% Load the rural day name 
    ruralDayNames = readmatrix('ruralDayNames.csv', 'OutputType', 'string');
    ruralDayName = ruralDayNames(repDayOfYear);

    %% Create output string
    if repMonth < 13
        repMonthNames = readmatrix('frenchRepublicanMonths.csv', 'OutputType', 'string');
        repMonthName = repMonthNames(1, repMonth);
        if repDayOfMonth == 1
            newMonth = sprintf(' (%s)', repMonthNames(2, repMonth));
        else
            newMonth = '';
        end
        outString = sprintf('%d %s%s %d; %s', ...
            repDayOfMonth, repMonthName, newMonth, repYear, ruralDayName);
    else
        outString = sprintf('%s %d', ruralDayName, repYear);
    end
end
