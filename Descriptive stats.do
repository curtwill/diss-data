do "E:\Dissertation\Data\NC Data\Do Files\NC School Report Card Master"

loc g="E:\Dissertation\Data\NC Data\Graphs"

/////////////////////////Summary Statistics ////////////////////////////////////////////
foreach value in satavg satpct appart appass ibpart ibpass total_class_teacher_num total_nbpts_num flicensed_teach_pct tchyrs_0thru3_pct tchyrs_4thru10_pct tchyrs_11plus_pct class_teach_num nbpts_num advance_dgr_pct _1yr_tchr_trnovr_pct emer_prov_teach_pct lateral_teach_pct highqual_class_pct avg_daily_attend_pct crime sts lts exp sint books student_num grad4pct grad5pct spg met egs att {
 sum `value'
}

////////////////////////Histograms//////////////////////////////////////////////////////
foreach pct in appass ibpass total_class_teacher_num total_nbpts_num flicensed_teach_pct tchyrs_0thru3_pct tchyrs_4thru10_pct tchyrs_11plus_pct advance_dgr_pct _1yr_tchr_trnovr_pct highqual_class_pct grad4pct grad5pct PerformanceCompositePercentCo PerformanceCompositePercentGr MathIPercentCollegeCareerRe MathIPercentGradeLevelProfi BiologyPercentCollegeCareerR BiologyPercentGradeLevelProf EnglishIIPercentCollegeCaree EnglishIIPercentGradeLevelP Grade3MathPercentCollegeCar Grade3MathPercentGradeLevel Grade4MathPercentCollegeCar Grade4MathPercentGradeLevel Grade5MathPercentCollegeCar Grade5MathPercentGradeLevel Grade6MathPercentCollegeCar Grade6MathPercentGradeLevel Grade7MathPercentCollegeCar Grade7MathPercentGradeLevel Grade8MathPercentCollegeCar Grade8MathPercentGradeLevel Grade3ReadingPercentCollege Grade3ReadingPercentGradeLe Grade4ReadingPercentCollege Grade4ReadingPercentGradeLe Grade5ReadingPercentCollege Grade5ReadingPercentGradeLe Grade6ReadingPercentCollege Grade6ReadingPercentGradeLe Grade7ReadingPercentCollege Grade7ReadingPercentGradeLe Grade8ReadingPercentCollege Grade8ReadingPercentGradeLe Grade5SciencePercentCollege Grade5SciencePercentGradeLe Grade8SciencePercentCollege Grade8SciencePercentGradeLe {
histogram `pct', percent saving (`pct'.gph, replace)
}

histogram grad4pct if year==2014, percent saving(2014gr.gph, replace)bin(40)
histogram grad4pct if year==2015, percent saving(2015gr.gph, replace)bin(40)
histogram grad4pct if year==2016, percent saving(2016gr.gph,replace)bin(40)
graph combine 2014gr.gph 2015gr.gph 2016gr.gph , row(1) ycommon xcommon

histogram spg, percent

///////////////////////Scatterplots & Twoway Graphs////////////////////////////////////////////////////

foreach value in sts lts exp { 
scatter spg `value', saving(`value')
}
scatter ap_pct_3_or_above sts


//check with helpgraph combine

tw(connected grad4pct year if grad4pct<. in 1/1000,sort  ), by(SchoolCode)
tw(connected grad4pct spg if grad4pct<. in 1/100, sort), by(SchoolCode)
scatter spg sts if year==2014
graph save Graph "E:\Dissertation\Data\NC Data\Graphs\Scatterplot of spg sts in 2014.gph"
scatter spg sts if year==2015
graph save Graph "E:\Dissertation\Data\NC Data\Graphs\Scatterplot of spg sts in 2015.gph"
scatter spg sts if year==2016
graph save Graph "E:\Dissertation\Data\NC Data\Graphs\Scatterplot of spg sts in 2016.gph"

//////////////////////////////////correlations//////////////////////////////////////
foreach value in crime sts lts exp{
correlate `value' spg
}
graph pie, over(spg)

la var "fvx ratio"
repace v=v*100
xtset jj  year

scatter met sts

// Model for doing a scatterplot with variables: scatter lea_adva lea_lat,mlab(SchoolCode)*//
//////////////////////////////Tabulations of key variables by year/////////////////////////////
foreach value in spg met {
tab `value' if year==2014
tab `value' if year==2015
tab `value' if year==2016
}
histogram spg if year==2014


////////////////Correlations between STS and other variables of interest*//////////////

//do at once and add significance
pwcorr ect sts
pwcorr mct sts
pwcorr sct sts
pwcorr ada sts 

/////////////////////Bar Charts////////////////////////////////////////////////////////

graph bar, over(spg)
graph bar (count), over(spg)
graph bar, over(met)

/////////////////////ideas///////////////
//all of them athhe sam etime
sysuse auto,clear

//if continuous
gr matrix wei len pri mpg, half

//and if categorical do bar  charts
//start simple and then keep on adding complexity
gr bar mpg, by(foreign) over(rep78) over(headr)



