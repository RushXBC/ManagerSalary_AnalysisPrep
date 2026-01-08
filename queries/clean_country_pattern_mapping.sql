/*
    Purpose: Clean and categorize the 'country' column in the manager_salary table.
    - The column contains messy, inconsistent, and free-text country entries entered by real people.
    - This query standardizes entries into recognizable countries or regions.
    - It handles common variations, misspellings, emojis, city names, and territories.
    - Entries that do not match any known patterns are labeled as 'Other'.
*/
SELECT
    country AS country_raw,
    CASE
        /* =========================
            UNITED STATES (+ territories & cities)
            - Matches common variations, misspellings, emojis, and city names.
            - Converts entries like 'usa', 'U.S.', 'california', 'hartford', '🇺🇸' to 'United States'.
        ========================== */
        WHEN LOWER(country) LIKE '%united states%'
            OR LOWER(country) LIKE '%u.s%'
            OR LOWER(country) LIKE '%usa%'
            OR LOWER(country) LIKE '%us of a%'
            OR LOWER(country) LIKE '%america%'
            OR LOWER(country) LIKE '%🇺🇸%'
            OR LOWER(country) LIKE '%the us%'
            OR LOWER(country) LIKE '%california%'
            OR LOWER(country) LIKE '%virginia%'
            OR LOWER(country) LIKE '%hartford%'
            OR LOWER(country) LIKE '%san francisco%'
            OR LOWER(country) LIKE '%unitedstates%'
            OR LOWER(country) LIKE '%united s%'
            OR LOWER(country) LIKE '%unites s%'
            OR LOWER(country) LIKE '%usaa%'
            OR LOWER(country) LIKE '%usat%'
            OR LOWER(country) LIKE '%usab%'
            OR LOWER(country) LIKE '%u s%'
            OR LOWER(country) LIKE '%US%'
            OR LOWER(country) LIKE '%ISA%'
            OR LOWER(country) LIKE '%U.%'
            OR LOWER(country) LIKE '%States%'
            OR LOWER(country) LIKE '%unitied states%'
            OR LOWER(country) LIKE '%untied states%'
            OR LOWER(country) LIKE '%uniteed states%'
            OR LOWER(country) LIKE '%uniter statez%'
            OR LOWER(country) LIKE '%unitef stated%'
            OR country = N'🇺🇸'
        THEN 'United States'

        /* =========================
            PUERTO RICO
            - Matches the territory Puerto Rico
        ========================== */
        WHEN LOWER(country) LIKE '%puerto rico%' THEN 'Puerto Rico'

        /* =========================
            UNITED KINGDOM
            - Includes UK, U.K., Britain, cities, and common misspellings
        ========================== */
        WHEN LOWER(country) LIKE '%united kingdom%'
            OR LOWER(country) LIKE '%uk%'
            OR LOWER(country) LIKE '%u.k%'
            OR LOWER(country) LIKE '%britain%'
            OR LOWER(country) LIKE '%great britain%'
            OR LOWER(country) LIKE '%england%'
            OR LOWER(country) LIKE '%scotland%'
            OR LOWER(country) LIKE '%wales%'
            OR LOWER(country) LIKE '%northern ireland%'
            OR LOWER(country) LIKE '%london%'
            OR LOWER(country) LIKE '%gb%'
            OR LOWER(country) LIKE '%united kindom%'
            OR LOWER(country) LIKE '%unites kingdom%'
            OR LOWER(country) LIKE '%Englang%'
        THEN 'United Kingdom'

        /* =========================
            CANADA
            - Covers Canada, misspellings, and Ottawa
        ========================== */
        WHEN LOWER(country) LIKE '%canada%'
            OR LOWER(country) LIKE '%canadá%'
            OR LOWER(country) LIKE '%ottawa%'
            OR LOWER(country) LIKE '%canadw%'
            OR LOWER(country) LIKE '%canda%'
            OR LOWER(country) LIKE '%canad%'
            OR LOWER(country) LIKE '%csnada%'
        THEN 'Canada'

        /* =========================
            AUSTRALIA
            - Matches variations like 'australia', 'australi', 'australian'
        ========================== */
        WHEN LOWER(country) LIKE '%australia%'
            OR LOWER(country) LIKE '%australi%'
            OR LOWER(country) LIKE '%australian%'
        THEN 'Australia'

        /* =========================
            NEW ZEALAND
            - Matches 'New Zealand', 'Aotearoa', 'NZ'
        ========================== */
        WHEN LOWER(country) LIKE '%new zealand%'
            OR LOWER(country) LIKE '%aotearoa%'
            OR LOWER(country) LIKE '%nz%'
        THEN 'New Zealand'

        /* =========================
            NETHERLANDS
            - Matches common names and abbreviations
        ========================== */
        WHEN LOWER(country) LIKE '%netherlands%'
            OR LOWER(country) LIKE '%nederland%'
            OR LOWER(country) LIKE '%nl%'
        THEN 'Netherlands'

        /* =========================
            UNITED ARAB EMIRATES
            - Matches full name and abbreviations like UAE
        ========================== */
        WHEN LOWER(country) LIKE '%united arab emirates%'
            OR LOWER(country) LIKE '%uae%'
            OR LOWER(country) LIKE '%u.a.%'
        THEN 'United Arab Emirates'

        /* =========================
            CHINA (including Hong Kong)
            - Covers common variations and typos
        ========================== */
        WHEN LOWER(country) LIKE '%china%'
            OR LOWER(country) LIKE '%hong kong%'
            OR LOWER(country) LIKE '%hong konh%'
        THEN 'China'

        /* =========================
            SOUTH KOREA
            - Includes 'south korea' and general 'korea'
        ========================== */
        WHEN LOWER(country) LIKE '%south korea%'
            OR LOWER(country) LIKE '%korea%'
        THEN 'South Korea'

        /* =========================
            EUROPE (other countries)
            - Includes common European countries, corrections for typos
        ========================== */
        WHEN LOWER(country) LIKE '%finland%' THEN 'Finland'
        WHEN LOWER(country) LIKE '%france%' THEN 'France'
        WHEN LOWER(country) LIKE '%germany%' THEN 'Germany'
        WHEN LOWER(country) LIKE '%italy%' OR LOWER(country) LIKE '%italia%' THEN 'Italy'
        WHEN LOWER(country) LIKE '%spain%' THEN 'Spain'
        WHEN LOWER(country) LIKE '%portugal%' THEN 'Portugal'
        WHEN LOWER(country) LIKE '%sweden%' THEN 'Sweden'
        WHEN LOWER(country) LIKE '%norway%' THEN 'Norway'
        WHEN LOWER(country) LIKE '%denmark%' OR LOWER(country) LIKE '%danmark%' THEN 'Denmark'
        WHEN LOWER(country) LIKE '%ireland%' THEN 'Ireland'
        WHEN LOWER(country) LIKE '%belgium%' THEN 'Belgium'
        WHEN LOWER(country) LIKE '%austria%' THEN 'Austria'
        WHEN LOWER(country) LIKE '%switzerland%' THEN 'Switzerland'
        WHEN LOWER(country) LIKE '%poland%' THEN 'Poland'
        WHEN LOWER(country) LIKE '%czech%' OR LOWER(country) LIKE '%česk%' OR LOWER(country) LIKE '%ceska%' THEN 'Czech Republic'
        WHEN LOWER(country) LIKE '%slovakia%' THEN 'Slovakia'
        WHEN LOWER(country) LIKE '%slovenia%' THEN 'Slovenia'
        WHEN LOWER(country) LIKE '%hungary%' THEN 'Hungary'
        WHEN LOWER(country) LIKE '%greece%' THEN 'Greece'
        WHEN LOWER(country) LIKE '%luxembourg%' OR LOWER(country) LIKE '%luxemburg%' THEN 'Luxembourg'
        WHEN LOWER(country) LIKE '%latvia%' THEN 'Latvia'
        WHEN LOWER(country) LIKE '%lithuania%' THEN 'Lithuania'
        WHEN LOWER(country) LIKE '%estonia%' THEN 'Estonia'
        WHEN LOWER(country) LIKE '%romania%' THEN 'Romania'
        WHEN LOWER(country) LIKE '%bulgaria%' THEN 'Bulgaria'
        WHEN LOWER(country) LIKE '%croatia%' THEN 'Croatia'
        WHEN LOWER(country) LIKE '%bosnia%' THEN 'Bosnia and Herzegovina'
        WHEN LOWER(country) LIKE '%serbia%' THEN 'Serbia'
        WHEN LOWER(country) LIKE '%ukraine%' THEN 'Ukraine'
        WHEN LOWER(country) LIKE '%russia%' THEN 'Russia'
        WHEN LOWER(country) LIKE '%isle of man%' THEN 'Isle of Man'
        WHEN LOWER(country) LIKE '%malta%' THEN 'Malta'
        WHEN country = N'Česká republika' OR LOWER(country) LIKE '%czech%' THEN 'Czech Republic'

        /* =========================
            ASIA
            - Matches major Asian countries, includes common typos
        ========================== */
        WHEN LOWER(country) LIKE '%philippines%' THEN 'Philippines'
        WHEN LOWER(country) LIKE '%india%' OR LOWER(country) LIKE '%ibdia%' THEN 'India'
        WHEN LOWER(country) LIKE '%japan%' THEN 'Japan'
        WHEN LOWER(country) LIKE '%thailand%' THEN 'Thailand'
        WHEN LOWER(country) LIKE '%vietnam%' THEN 'Vietnam'
        WHEN LOWER(country) LIKE '%singapore%' THEN 'Singapore'
        WHEN LOWER(country) LIKE '%pakistan%' THEN 'Pakistan'
        WHEN LOWER(country) LIKE '%malaysia%' THEN 'Malaysia'
        WHEN LOWER(country) LIKE '%indonesia%' THEN 'Indonesia'
        WHEN LOWER(country) LIKE '%sri lanka%' THEN 'Sri Lanka'

        /* =========================
            EVERYTHING ELSE
            - If no match found, label as 'Other'
        ========================== */
        ELSE 'Other'
    END AS country_clean
FROM dbo.manager_salary;
