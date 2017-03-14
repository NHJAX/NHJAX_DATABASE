CREATE Function Is_numeric(@value varchar(25))
Returns bit
as
Begin
Return
(
case
when @value not like '%[^-0-9.]%' and ((charindex('.',@value)>0 and len(@value)-len(replace(@value,'.',''))=1 and len(@value)>1) or charindex('.',@value)=0) 
and 
1=
(
case when charindex('-',@value)>0 then
case when left(@value,1)='-' and len(@value)-len(replace(@value,'-',''))<2 and len(@value)>1 then 
1 
else 
0 
end
else
1
end
) then

1
else
0
end
)
End

