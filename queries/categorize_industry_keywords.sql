/*
    Purpose: Clean and categorize the 'industry' column in the manager_salary table.
    - The column contains 1010 distinct free-text entries entered by real people.
    - Entries are messy and inconsistent, so we map them into 28 (including "Other") broader categories.
    - This standardization makes analysis easier and more meaningful.
    - Entries that do not match any known keywords are labeled as 'Other'.
*/
SELECT
    industry,
    CASE
        -- We use LOWER() to convert the industry name to all lowercase letters. 
        -- This ensures our keyword search is not case-sensitive.
        -- PATINDEX() searches for the presence of specified keywords in the industry string.
        -- If PATINDEX returns a number greater than 0, it means at least one keyword was found.
        
        -- 1 Aerospace & Defense
        WHEN PATINDEX('%aerospace%', LOWER(industry)) > 0 
          OR PATINDEX('%defense%', LOWER(industry)) > 0 
          OR PATINDEX('%aviation%', LOWER(industry)) > 0
        THEN 'Aerospace & Defense'

        -- 2 Agriculture, Forestry & Natural Resources
        WHEN PATINDEX('%agriculture%', LOWER(industry)) > 0 
          OR PATINDEX('%forestry%', LOWER(industry)) > 0 
          OR PATINDEX('%natural resource%', LOWER(industry)) > 0
        THEN 'Agriculture, Forestry & Natural Resources'

        -- 3 Architecture, Engineering & Construction
        WHEN PATINDEX('%architecture%', LOWER(industry)) > 0 
          OR PATINDEX('%engineering%', LOWER(industry)) > 0 
          OR PATINDEX('%construction%', LOWER(industry)) > 0
        THEN 'Architecture, Engineering & Construction'

        -- 4 Arts, Culture & Heritage
        WHEN PATINDEX('%arts%', LOWER(industry)) > 0 
          OR PATINDEX('%culture%', LOWER(industry)) > 0 
          OR PATINDEX('%heritage%', LOWER(industry)) > 0 
          OR PATINDEX('%museum%', LOWER(industry)) > 0
        THEN 'Arts, Culture & Heritage'

        -- 5 Automotive & Transportation Manufacturing
        WHEN PATINDEX('%automotive%', LOWER(industry)) > 0 
          OR PATINDEX('%auto%', LOWER(industry)) > 0 
          OR PATINDEX('%vehicle%', LOWER(industry)) > 0
        THEN 'Automotive & Transportation Manufacturing'

        -- 6 Banking, Finance & Accounting
        WHEN PATINDEX('%bank%', LOWER(industry)) > 0 
          OR PATINDEX('%finance%', LOWER(industry)) > 0 
          OR PATINDEX('%account%', LOWER(industry)) > 0
        THEN 'Banking, Finance & Accounting'

        -- 7 Biotechnology, Life Sciences & Pharmaceuticals
        WHEN PATINDEX('%biotech%', LOWER(industry)) > 0 
          OR PATINDEX('%pharma%', LOWER(industry)) > 0 
          OR PATINDEX('%life sciences%', LOWER(industry)) > 0 
          OR PATINDEX('%biological%', LOWER(industry)) > 0
        THEN 'Biotechnology, Life Sciences & Pharmaceuticals'

        -- 8 Chemicals & Materials Manufacturing
        WHEN PATINDEX('%chemical%', LOWER(industry)) > 0 
          OR PATINDEX('%materials%', LOWER(industry)) > 0
        THEN 'Chemicals & Materials Manufacturing'

        -- 9 Consumer Goods & Retail
        WHEN PATINDEX('%consumer good%', LOWER(industry)) > 0 
          OR PATINDEX('%retail%', LOWER(industry)) > 0 
          OR PATINDEX('%cpd%', LOWER(industry)) > 0 
          OR PATINDEX('%product%', LOWER(industry)) > 0
        THEN 'Consumer Goods & Retail'

        -- 10 Education & Training
        WHEN PATINDEX('%education%', LOWER(industry)) > 0 
          OR PATINDEX('%training%', LOWER(industry)) > 0 
          OR PATINDEX('%school%', LOWER(industry)) > 0 
          OR PATINDEX('%university%', LOWER(industry)) > 0 
          OR PATINDEX('%college%', LOWER(industry)) > 0
        THEN 'Education & Training'

        -- 11 Energy & Utilities (including Oil, Gas, Renewables)
        WHEN PATINDEX('%energy%', LOWER(industry)) > 0 
          OR PATINDEX('%oil%', LOWER(industry)) > 0 
          OR PATINDEX('%gas%', LOWER(industry)) > 0 
          OR PATINDEX('%renewable%', LOWER(industry)) > 0 
          OR PATINDEX('%utility%', LOWER(industry)) > 0
        THEN 'Energy & Utilities'

        -- 12 Food & Beverage Production and Services
        WHEN PATINDEX('%food%', LOWER(industry)) > 0 
          OR PATINDEX('%beverage%', LOWER(industry)) > 0 
          OR PATINDEX('%restaurant%', LOWER(industry)) > 0 
          OR PATINDEX('%brewery%', LOWER(industry)) > 0 
          OR PATINDEX('%catering%', LOWER(industry)) > 0
        THEN 'Food & Beverage Production and Services'

        -- 13 Government & Public Administration
        WHEN PATINDEX('%government%', LOWER(industry)) > 0 
          OR PATINDEX('%public administration%', LOWER(industry)) > 0 
          OR PATINDEX('%federal%', LOWER(industry)) > 0 
          OR PATINDEX('%state%', LOWER(industry)) > 0 
          OR PATINDEX('%municipal%', LOWER(industry)) > 0
        THEN 'Government & Public Administration'

        -- 14 Healthcare & Medical Services
        WHEN PATINDEX('%health%', LOWER(industry)) > 0 
          OR PATINDEX('%medical%', LOWER(industry)) > 0 
          OR PATINDEX('%hospital%', LOWER(industry)) > 0 
          OR PATINDEX('%clinic%', LOWER(industry)) > 0
        THEN 'Healthcare & Medical Services'

        -- 15 Hospitality, Tourism & Leisure
        WHEN PATINDEX('%hospitality%', LOWER(industry)) > 0 
          OR PATINDEX('%tourism%', LOWER(industry)) > 0 
          OR PATINDEX('%hotel%', LOWER(industry)) > 0 
          OR PATINDEX('%resort%', LOWER(industry)) > 0 
          OR PATINDEX('%leisure%', LOWER(industry)) > 0
        THEN 'Hospitality, Tourism & Leisure'

        -- 16 Information Technology & Software
        WHEN PATINDEX('%tech%', LOWER(industry)) > 0 
          OR PATINDEX('%software%', LOWER(industry)) > 0 
          OR PATINDEX('%computing%', LOWER(industry)) > 0 
          OR PATINDEX('%it%', LOWER(industry)) > 0 
          OR PATINDEX('%saas%', LOWER(industry)) > 0
        THEN 'Information Technology & Software'

        -- 17 Legal & Compliance
        WHEN PATINDEX('%legal%', LOWER(industry)) > 0 
          OR PATINDEX('%compliance%', LOWER(industry)) > 0 
          OR PATINDEX('%law%', LOWER(industry)) > 0
        THEN 'Legal & Compliance'

        -- 18 Logistics, Supply Chain & Transportation
        WHEN PATINDEX('%logistics%', LOWER(industry)) > 0 
          OR PATINDEX('%supply chain%', LOWER(industry)) > 0 
          OR PATINDEX('%transportation%', LOWER(industry)) > 0
        THEN 'Logistics, Supply Chain & Transportation'

        -- 19 Media, Communications & Publishing
        WHEN PATINDEX('%media%', LOWER(industry)) > 0 
          OR PATINDEX('%communication%', LOWER(industry)) > 0 
          OR PATINDEX('%publishing%', LOWER(industry)) > 0 
          OR PATINDEX('%journalism%', LOWER(industry)) > 0
        THEN 'Media & Communications'

        -- 20 Nonprofit & Social Services
        WHEN PATINDEX('%nonprofit%', LOWER(industry)) > 0 
          OR PATINDEX('%social service%', LOWER(industry)) > 0 
          OR PATINDEX('%charity%', LOWER(industry)) > 0
        THEN 'Nonprofit & Social Services'

        -- 21 Professional Services & Consulting
        WHEN PATINDEX('%consulting%', LOWER(industry)) > 0 
          OR PATINDEX('%professional service%', LOWER(industry)) > 0
        THEN 'Professional Services & Consulting'

        -- 22 Real Estate & Property Management
        WHEN PATINDEX('%real estate%', LOWER(industry)) > 0 
          OR PATINDEX('%property%', LOWER(industry)) > 0
        THEN 'Real Estate & Property Management'

        -- 23 Science & Laboratory Research
        WHEN PATINDEX('%science%', LOWER(industry)) > 0 
          OR PATINDEX('%research%', LOWER(industry)) > 0 
          OR PATINDEX('%laboratory%', LOWER(industry)) > 0
        THEN 'Science & Laboratory Research'

        -- 24 Security & Safety Services
        WHEN PATINDEX('%security%', LOWER(industry)) > 0 
          OR PATINDEX('%safety%', LOWER(industry)) > 0 
          OR PATINDEX('%protection%', LOWER(industry)) > 0
        THEN 'Security & Safety Services'

        -- 25 Telecommunications
        WHEN PATINDEX('%telecommunication%', LOWER(industry)) > 0 
          OR PATINDEX('%telecom%', LOWER(industry)) > 0
        THEN 'Telecommunications'

        -- 26 Veterinary & Animal Health
        WHEN PATINDEX('%veterinary%', LOWER(industry)) > 0 
          OR PATINDEX('%animal health%', LOWER(industry)) > 0 
          OR PATINDEX('%vet%', LOWER(industry)) > 0
        THEN 'Veterinary & Animal Health'

        -- 27 Waste Management & Environmental Services
        WHEN PATINDEX('%waste%', LOWER(industry)) > 0 
          OR PATINDEX('%environment%', LOWER(industry)) > 0 
          OR PATINDEX('%recycling%', LOWER(industry)) > 0
        THEN 'Waste Management & Environmental Services'

        -- Default category
        ELSE 'Other'
    END AS industry_group
FROM dbo.manager_salary;
