# bmi

a simple bmi calculator

## Errors:
1. Logout fails
2. Signup fails as id is wrongly saved
3. Generated files are missing need to be regenerated
4. Localisation files also need to generated
5. Get all records use case need to be added to injectable
6. Form context not being found for validation of create form
7. Bottom sheet not opening correctly
8. Use of showBottomSheet instead of showModalBottomSheet
9. BmiRecordAdapter typeId is set to an invalid value

## Bugs:
1. Past records only 1 result is visible
2. Height and weight units are wrong
3. Bmi calculator is wrong need to be multiplied by 10000
4. Logout doesn’t work
5. Signup doesn’t work
6. Wrong email validation error in login form
7. Latest bmi record is wrong as it is fetching the oldest record instead of latest one
8. Save bmi record doesn’t work as expected as user id is wrongly at the source
9. Helper text is wrong in create form for height field
10. Height maximum validator value is wrongly set
11. Weight and height value are getting saved in place of height and weight respectively.
12. Weight field obscure text is set to true
13. MinimumLengthValidator logic is wrong