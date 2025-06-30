-- Data Cleaning Project


-- REMOVE DUPLICATES
-- STANDARDIZE THE DATA 
-- NULL VALUES OR BLANK VALUES
-- REMOVE ANY COUMNS OR ROWS


select*
from world_layoffs.layoffs;

create table world_layoffs.layoffs_staging
like world_layoffs.layoffs;

insert world_layoffs.layoffs_staging
select*
from world_layoffs.layoffs;

select*
from world_layoffs.layoffs_staging
;

with duplicate_cte as
(
select*,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`,
 stage, country, funds_raised_millions) as row_num
from world_layoffs.layoffs_staging
)
select*
from duplicate_cte
where row_num >1;

select*
from world_layoffs.layoffs_staging
where company = 'casper';


CREATE TABLE world_layoffs.layoffs_staging2 (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select*
from world_layoffs.layoffs_staging2;

insert into world_layoffs.layoffs_staging2
select*,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`,
 stage, country, funds_raised_millions) as row_num
from world_layoffs.layoffs_staging;

select*
from world_layoffs.layoffs_staging2;

-- standardizing data

select company, (trim(company))
from world_layoffs.layoffs_staging2;

update world_layoffs.layoffs_staging2
set company = trim(company);

select industry
from world_layoffs.layoffs_staging2
order by 1;

select*
from world_layoffs.layoffs_staging2
where industry like 'crypto%';

update world_layoffs.layoffs_staging2
set industry = 'crypto'
where industry like 'crypto%';

select distinct country, trim(trailing '.' from country)
from world_layoffs.layoffs_staging2
order by 1;

update world_layoffs.layoffs_staging2
set country  = trim(trailing '.' from country)
where country like 'united states%';

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from world_layoffs.layoffs_staging2;

update world_layoffs.layoffs_staging2
set `date`  = str_to_date(`date`, '%m/%d/%Y');

alter table world_layoffs.layoffs_staging2
modify column `date` date;

-- clearing null values

update world_layoffs.layoffs_staging2
set industry = null
where industry = '';

select t1.industry, t2.industry
from world_layoffs.layoffs_staging2 t1
join world_layoffs.layoffs_staging2 t2
	on t1.company = t2.company
where(t1.industry is NULL or t1.industry = '')
and t2.industry is not null;

update world_layoffs.layoffs_staging2 t1
join world_layoffs.layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is NULL
and t2.industry is not NULL;

select*
from world_layoffs.layoffs_staging2
where company = 'airbnb';

select*
from world_layoffs.layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;

delete
from world_layoffs.layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is NULL;

alter table world_layoffs.layoffs_staging2
drop column row_num;

select*
from world_layoffs.layoffs_staging2