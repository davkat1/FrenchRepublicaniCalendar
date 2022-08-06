function createFrenchRepublicaniCalendar(startDate, endDate, outputFile)
% Create an iCalendar (.ics) file with French Republican dates.
%
% Usage:
%   createFrenchRepublicaniCalendar(startDate, endDate, outputFile)
% Inputs:
%   startDate       Date where iCalendar starts (in dd-mm-yyyy format)
%                   If no argument is given, '01-01-2023' is used
%   endDate         Date where iCalendar end (in dd-mm-yyyy format)
%                   If no argument is given, '31-12-2023' is used
%   outputFile      File name for the created iCal file.
%                   If no argument is given, the name
%                   FrenchRepublicanCalendar_<startDate>-<endDate>.ics
%                   will be used.
%                   The function will not allow overwriting, so if
%                   outputFile already exists, an error will be thrown.
% 
% The funcion creates an iCalendar (.ics) file with the name outputFile,
% that has for each day within the given range, an event with the following
% properties:
%   Status: free
%   Reminder: none
%   Duration: all day
%   Name: <day of month> <month> <year>; <rural day name>
%       with day of month, month, year, and rural day name 
%       according to the French Republican calendar.
%       The rural day name is given in English, following the translation
%       in Wikipedia, https://en.wikipedia.org/wiki/French_Republican_calendar#Rural_calendar
%       as it appeared on 19 Thermidor 230 (August 6, 2022).
%       The month name is given in French, with a translation to English on
%       the 1st of each month.
%       The complementary days are given in French with an English
%       translation.
% Conversion from Greogrian to Republican dates is done according to the
% Equinox method for the years 1-15 of the Republic (1792-1805). From year
% 15 on, the Romme method is used, see readme. Dates before initiation of
% the calendar (22-09-1792) will appear as NaN.

% Created by David Katzin, Thermidor 230 (August 2022)
% david.katzin1@gmail.com
% https://github.com/davkat1/FrenchRepublicaniCalendar


    %% Set default parameters
    if ~exist('startDate', 'var') || isempty(startDate)
        startDate = '01-01-2023';
    end
    if ~exist('endDate', 'var') || isempty(endDate)
        startDate = '31-12-2023';
    end
    if ~exist('outputFile', 'var') || isempty(outputFile)
        outputFile = sprintf('FrenchRepublicanCalnedar_%s-%s', ...
            strrep(startDate,'-',''), strrep(endDate,'-',''));
    end
    if ~strcmp(outputFile(end-3:end), '.ics')
        outputFile = [outputFile '.ics'];
    end

    startDate = datetime(startDate,'InputFormat','dd-MM-yyyy');
    endDate = datetime(endDate,'InputFormat','dd-MM-yyyy');
    
    if exist(outputFile, 'file')
        error('File %s already exists', outputFile);
    end

    %% Create output file
    fileID = fopen(outputFile, 'w')';
    
    calStart = sprintf('%sT000000',datestr(startDate, 'yyyymmdd'));
    calEnd = sprintf('%sT000000',datestr(endDate, 'yyyymmdd'));
    calName = 'French Republican';
    
    fprintf(fileID, ...
        ['BEGIN:VCALENDAR\n' ...
            'PRODID:-//Microsoft Corporation//Outlook 16.0 MIMEDIR//EN\n' ...
            'VERSION:2.0\n' ...
            'METHOD:PUBLISH\n' ...
            'X-CALSTART:%s\n' ...
            'X-CALEND:%s\n' ...
            'X-WR-CALNAME:%s\n'], ...
        calStart, calEnd, calName);
    
    for day=startDate:endDate
        fprintf(fileID, ...
        ['BEGIN:VEVENT\n' ...
            'CLASS:PUBLIC\n' ...
            'DTEND;VALUE=DATE:%s\n' ...
            'DTSTART;VALUE=DATE:%s\n' ...
            'PRIORITY:5\n' ...
            'SEQUENCE:0\n' ...
            'SUMMARY;LANGUAGE=en-gb:%s\n' ...
            'TRANSP:TRANSPARENT\n' ...
            'X-MICROSOFT-CDO-BUSYSTATUS:FREE\n' ...
            'X-MICROSOFT-CDO-IMPORTANCE:1\n' ...
            'X-MICROSOFT-DISALLOW-COUNTER:FALSE\n' ...
            'X-MS-OLK-CONFTYPE:0\n' ...
            'END:VEVENT\n'], ...
        datestr(day+1,'yyyymmdd'), ...
        datestr(day, 'yyyymmdd'), ...
        greg2rep(day));
    end
    
    
    fprintf(fileID,'END:VCALENDAR');
    fclose(fileID);
end