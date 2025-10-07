/*** Allard Group jun.allard@uci.edu                    ***/

void getSites();


/*******************************************************************************/
//  GLOBAL VARIABLES for output control
/*******************************************************************************/
long siteCounter,bSiteCounter;

/********************************************************************************************************/
void getSites()
{
    /********* INITIALIZE ISITES *******************/
    
   
    // initialize iSiteTotal, iSites
    for(nf=0;nf<NFil;nf++)
    {
        iSiteTotal[nf] = N[nf];
        for(iy=0;iy<iSiteTotal[nf];iy++)
        {
            iSite[nf][iy]=0;
        }
    }
    
    // set iSites to all segments
    for(nf=0;nf<NFil;nf++)
    {
        for(iy=0;iy<iSiteTotal[nf];iy++)
        {
            iSite[nf][iy]=iy;
        }
    }
    
    // Determine total number of iSites for system
    NumberiSites = 0;
    for(nf=0;nf<NFil;nf++)
        NumberiSites += iSiteTotal[nf];
    
    //Warning for possible user error
    for(nf=0;nf<NFil;nf++)
    {
        for (iy=0; iy<iSiteTotal[nf];iy++)
        {
            if (iSite[nf][iy] >= N[nf])
            {
                printf("Warning! Site is located past end of polymer in filament %ld!\n",nf);
                fflush(stdout);
            }
        }
    }
    
    //for debugging - prints a list of the iSites
    if (TALKATIVE)
    {
        for(nf=0;nf<NFil;nf++)
        {
            printf("Filament: %ld\n", nf);
            fflush(stdout);
            
            for (iy=0;iy<iSiteTotal[nf];iy++)
            {
                printf("iSite: %ld\n", iSite[nf][iy]);
                fflush(stdout);
            }
            
            printf("iSiteTotal: %ld\n", iSiteTotal[nf]);
            fflush(stdout);
        }
        
        printf("Number of iSites in system: %ld\n",NumberiSites);
        fflush(stdout);
    }
    

}

/********************************************************************************************************/

