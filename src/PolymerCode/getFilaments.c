/*** Allard Group jun.allard@uci.edu                    ***/

void getFilaments();


/*******************************************************************************/
//  GLOBAL VARIABLES for output control
/*******************************************************************************/


/********************************************************************************************************/
void getFilaments()
{
    /********* INITIALIZE Filaments *******************/
    
    for(nf=0;nf<NFil;nf++)
    {
        N[nf]=Ntemp;
        if (TALKATIVE) printf("This is number of rods in filament %ld: %ld\n",nf, N[nf]);
    }
    
    //for debugging - prints a list of the filament lengths
    if (TALKATIVE)
    {
        for(nf=0;nf<NFil;nf++)
        {
            printf("Filament: %ld\n", nf);
            fflush(stdout);
            
            printf("N: %ld\n", N[nf]);
            fflush(stdout);
        }
    }
    
}

/********************************************************************************************************/

