USE LearnSQL
/**Intermediate SQL**/

SELECT DISTINCT [type] 
FROM airports;

SELECT
    A.name
    ,A.latitude_deg
    ,A.longitude_deg
    ,A.iata_code
    ,A.elevation_ft
    ,ROUND(A.elevation_ft/3.28,1) AS Elevation_M
    ,A.iso_country

FROM
    airports A

WHERE 
    A.TYPE= 'large_airport'
    AND
    A.continent = 'EU'
    AND
    A.iso_country IN ('GB','FR') --- List
    --AND
    ---A.latitude_deg BETWEEN '51' AND '54'  --- BETWEEN

ORDER BY A.NAME ASC

SELECT TOP 5
    a.iso_region
    ,COUNT(*) AS Total_Airports
FROM airports a
GROUP BY a.iso_region
ORDER BY Total_Airports DESC