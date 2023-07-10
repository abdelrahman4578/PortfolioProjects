/*
Cleaning Data in SQL Queries
*/

select *
from PortfolioProject.dbo.NashvilleHousing

----------------------------------------------------------------

-- Standrize Data Format


select SaleDate
from PortfolioProject.dbo.NashvilleHousing

alter table  PortfolioProject.dbo.NashvilleHousing
alter column SaleDate Date

----------------------------------------------------------------

-- Populate Property Address Data

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,
isnull(a.PropertyAddress,b.PropertyAddress)
from PortfolioProject.dbo.NashvilleHousing a
join PortfolioProject.dbo.NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null
order by a.ParcelID

update a
set a.PropertyAddress=isnull(a.PropertyAddress,b.PropertyAddress)
from PortfolioProject.dbo.NashvilleHousing a
join PortfolioProject.dbo.NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null


----------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address,City,State)


select PropertyAddress
from PortfolioProject.dbo.NashvilleHousing


select PropertyAddress ,
substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress)) as address
from PortfolioProject.dbo.NashvilleHousing

alter table PortfolioProject.dbo.NashvilleHousing
add  PropertySplitAddress nvarchar(255)

update NashvilleHousing
set PropertySplitAddress=substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)


alter table PortfolioProject.dbo.NashvilleHousing
add  PropertySplitCity nvarchar(255)


update NashvilleHousing
set PropertySplitCity=SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))

select *
from PortfolioProject.dbo.NashvilleHousing



select OwnerAddress
from NashvilleHousing


select 
PARSENAME(REPLACE(OwnerAddress,',','.'),3) as Address,
PARSENAME(REPLACE(OwnerAddress,',','.'),2) as City ,
PARSENAME(REPLACE(OwnerAddress,',','.'),1) as State
from NashvilleHousing

alter table NashvilleHousing
add OwnerSplitAddress nvarchar(255)

alter table NashvilleHousing
add OwnerSplitCity nvarchar(255)

alter table NashvilleHousing
add OwnerSplitState nvarchar(255)

update NashvilleHousing
set OwnerSplitAddress=PARSENAME(REPLACE(OwnerAddress,',','.'),3)

update NashvilleHousing
set OwnerSplitCity=PARSENAME(REPLACE(OwnerAddress,',','.'),2)

update NashvilleHousing
set OwnerSplitState=PARSENAME(REPLACE(OwnerAddress,',','.'),1)

select *
from NashvilleHousing


----------------------------------------------------------------

-- Change Y and N to Yes And No in "Sold as Vacant" field

select distinct  SoldAsVacant,count(SoldAsVacant)
from PortfolioProject.dbo.NashvilleHousing
group by SoldAsVacant
order by 2


select SoldAsVacant,
case
	when SoldAsVacant='N' then 'No'
	when SoldAsVacant='Y' then 'Yes'
	else SoldAsVacant
end
from PortfolioProject.dbo.NashvilleHousing

update NashvilleHousing
set SoldAsVacant=case
	when SoldAsVacant='N' then 'No'
	when SoldAsVacant='Y' then 'Yes'
	else SoldAsVacant
end

select distinct  SoldAsVacant,count(SoldAsVacant)
from PortfolioProject.dbo.NashvilleHousing
group by SoldAsVacant
order by 2


----------------------------------------------------------------

-- Remove Duplicates

with cte as (
select *,
ROW_NUMBER() 
over(partition by ParcelID,
PropertyAddress,
SalePrice,
SaleDate,
LegalReference
order by
UniqueID
) row_num
from NashvilleHousing
--order by ParcelID
)

delete 
from cte
where row_num>1

----------------------------------------------------------------

-- Delete Unused Columns

alter table NashvilleHousing
drop column	PropertyAddress,OwnerAddress,TaxDistrict

alter table NashvilleHousing
drop column	OwnerName

select *
from NashvilleHousing

-- Delete NULL Rows

delete 
from NashvilleHousing
where Acreage is null

delete 
from  NashvilleHousing
where Bedrooms is null or FullBath is null or YearBuilt is null


delete 
from  NashvilleHousing
where YearBuilt is null

delete  
from  NashvilleHousing
where HalfBath is null















