/*** Allard Group jun.allard@uci.edu                    ***/

void getParameters();


/*******************************************************************************/
//  GLOBAL VARIABLES for output control
/*******************************************************************************/
char tmpString[100];


/********************************************************************************************************/
void getParameters()
{
    paramsFile = fopen(paramsFilename,"r");
    
    fscanf(paramsFile,"%s %s", tmpString, listName);
    if (TALKATIVE) printf("This is output file name: %s\n", listName);
    
    fscanf(paramsFile,"%s %ld", tmpString, &NFil);
    if (TALKATIVE) printf("This is number of filaments: %ld\n", NFil);
    
    fscanf(paramsFile,"%s %ld", tmpString, &Ntemp);
    if (TALKATIVE) printf("This is number of rods in each filament: %ld\n",Ntemp);

    fscanf(paramsFile,"%s %lf", tmpString, &baseSepDistance);
    if (TALKATIVE) printf("This is the filament base separation distance: %lf\n", baseSepDistance);
    
    fscanf(paramsFile,"%s %lf", tmpString, &irLigand);
    if (TALKATIVE) printf("This is ligand radius: %lf\n", irLigand);
    
    fscanf(paramsFile,"%s %lf", tmpString, &brLigand);
    if (TALKATIVE) printf("This is bound ligand radius: %lf\n", brLigand);
    
    fscanf(paramsFile,"%s %lf", tmpString, &baserLigand);
    if (TALKATIVE) printf("This is base bound ligand radius: %lf\n", baserLigand);
    
    fscanf(paramsFile,"%s %lf", tmpString, &Force);
    if (TALKATIVE) printf("This is force: %f\n", Force);
    
    fscanf(paramsFile,"%s %lf", tmpString, &kdimer);
    if (TALKATIVE) printf("This is dimerization spring constant: %f\n", kdimer);

    fscanf(paramsFile,"%s %lf", tmpString, &dimerDist0);
    if (TALKATIVE) printf("This is dimerization rest distance: %f\n", dimerDist0);
    
    fscanf(paramsFile,"%s %d", tmpString, &verboseTF);
    if (TALKATIVE) printf("This is verbose: %d\n", verboseTF);
    
    fclose(paramsFile);
    
}

/********************************************************************************************************/

