#
# Template : batchsleep , Routine for sleep, argument is second
# Syntax : batchsleep("<int>");  // where <int> is second
# e.g. batchsleep("100"); // batch will pause for 100 sec and continue to execute
# Note - Sleep can not be less than 10 second. 
#  

sub batchsleep
{
    $sleepi = $1 ;

    for ( $bsi = 0 ; $bsi < $sleepi ; $bsi = $bsi + 10 )
    {
        sleep(10000);
        info("#### BATCH INFO : Batchsleep remaining time " . $sleepi - $bsi );
    } 
}

#
# Show current Time
# Syntax : showTime();
#
sub showTime
{
   $time = int((ticks() - $time) / 1000);
   println($time . "### CUSTOM : Loop TimeStamp second" . $time);
}

#-------------------------------------------------------------------#

#
# set default settings for band
# batch_defaultset("Int") where Int is 1170, 1280, 1390, 1660 sub-band
# e.g. batch_default("1280")
#

sub batch_defaultset
{
   $rfval = $1;
   
if ( $rfval == 1170 )
{
$cmd1 = command("frontend,init,3.1");
$cmds = waitforCmdCompletion( $cmd1 ,2);

$cmd2 = command("frontend,band,$rfval,$rfval");
$cmds = waitforCmdCompletion( $cmd2 ,2);

$cmd3 = command("frontend,swap,false");
$cmds = waitforCmdCompletion( $cmd3 ,2);

$cmd4 = command("frontend,rfattn,10,5");
$cmds = waitforCmdCompletion( $cmd4 ,2);

$cmd5 = command("frontend,cbterm,false,false");
$cmds = waitforCmdCompletion( $cmd5 ,2);

$cmd6 = command("sigcon,set lo,1110000");
$cmds = waitforCmdCompletion( $cmd6 ,2);

$cmd7 = command("sigcon,set attn,5,5");
$cmds = waitforCmdCompletion( $cmd7 ,2);

} else if ( $rfval == 1280 ) {

$cmd1 = command("frontend,init,3.1");
$cmds = waitforCmdCompletion( $cmd1 ,2);

$cmd2 = command("frontend,band,$rfval,$rfval");
$cmds = waitforCmdCompletion( $cmd2 ,2);

$cmd3 = command("frontend,swap,false");
$cmds = waitforCmdCompletion( $cmd3 ,2);

$cmd4 = command("frontend,rfattn,10,5");
$cmds = waitforCmdCompletion( $cmd4 ,2);

$cmd5 = command("frontend,cbterm,false,false");
$cmds = waitforCmdCompletion( $cmd5 ,2);

$cmd6 = command("sigcon,set lo,1220000");
$cmds = waitforCmdCompletion( $cmd6 ,2);

$cmd7 = command("sigcon,set attn,5,5");
$cmds = waitforCmdCompletion( $cmd7 ,2);

} else if ( $rfval == 1390 ) {

$cmd1 = command("frontend,init,3.1");
$cmds = waitforCmdCompletion( $cmd1 ,2);

$cmd2 = command("frontend,band,$rfval,$rfval");
$cmds = waitforCmdCompletion( $cmd2 ,2);

$cmd3 = command("frontend,swap,false");
$cmds = waitforCmdCompletion( $cmd3 ,2);

$cmd4 = command("frontend,rfattn,10,5");
$cmds = waitforCmdCompletion( $cmd4 ,2);

$cmd5 = command("frontend,cbterm,false,false");
$cmds = waitforCmdCompletion( $cmd5 ,2);

$cmd6 = command("sigcon,set lo,1330000");
$cmds = waitforCmdCompletion( $cmd6 ,2);

$cmd7 = command("sigcon,set attn,5,5");
$cmds = waitforCmdCompletion( $cmd7 ,2);

} else if ( $rfval == 1660 ) {
$cmd1 = command("frontend,init,3.1");
$cmds = waitforCmdCompletion( $cmd1 ,2);

$cmd2 = command("frontend,band,$rfval,$rfval");
$cmds = waitforCmdCompletion( $cmd2 ,2);

$cmd3 = command("frontend,swap,false");
$cmds = waitforCmdCompletion( $cmd3 ,2);

$cmd4 = command("frontend,rfattn,10,5");
$cmds = waitforCmdCompletion( $cmd4 ,2);

$cmd5 = command("frontend,cbterm,false,false");
$cmds = waitforCmdCompletion( $cmd5 ,2);

$cmd6 = command("sigcon,set lo,1600000");
$cmds = waitforCmdCompletion( $cmd6 ,2);

$cmd7 = command("sigcon,set attn,5,5");
$cmds = waitforCmdCompletion( $cmd7 ,2);
} else {
  error("### ERROR - batch_defaultset : Invalid Sub-band");
}

}

#-------------------------------------------------------------------#

#
#  batch_setlo : To set Sigcon LO Frequency
#  Syntax : batch_setlo(INT)  Frequency in KHz for e.g. 1330000

sub batch_setlo
{
  $loval = $1 ;
  $locmd = command("sigcon,set lo,$loval");
  $locmdresult = waitforCmdCompletion( $locmd ,10);
}

#-------------------------------------------------------------------#

#
# Switch on or of noise
# Syntax : batch_noise("<STRING>") where STRING is "OFF", "EHI","HI","MED","LOW"
# e.g. batch_noise("MED");
#

sub batch_noise
{
   @noiseStr = @("OFF" , "EHI" , "HI" , "MED" , "LOW");
   $noiseVal = $1;

#
#  By default make it OFF
#
   $ngcmd1 = command("frontend,ngset,false");
   $ngcmd1 = command("frontend,ngcal,off");

   if ( $noiseVal eq  @noiseStr[0] )
   {
        $ngcmd1 = command("frontend,ngset,false");
   }
   else
   {
	$ngcmd1 = command("frontend,ngset,true");
   }

   if ($ngcmd1 ne "") {
	info("### NGCAL $noiseVal");
        $ngcmd2 = command("frontend,ngcal,$noiseVal");
	$ngcmd2result = waitforCmdCompletion($ngcmd2 ,10);

	if ($ngcmd2result ne "") {
		info("### $NoiseVal CAL Triggerred");
		$ngcmd2status = getCommandStatus($ngcmd2);
		info("### $NoiseVal $ngcmd2status");
		$ngstatusint = getCommandStatusInt($ngcmd2status);
		info("command completed with status int $ngstatusint");
	}
  }
}

#-----------------------------------------------------------------------
# Track source
# Syntax : batch_tracksource("<SourceName>")
# e.g.     batch_tracksource("3C48");
#

sub batch_tracksource
{

$stopcmd = command("servo,stoptrack");
$trackCmd = command("servo,hold,B");

$srvcrdvar = getProperty("srvcrd");
if( $srvcrdvar == 1 )
{
$trackCmd = command("servo,goout,1");
info(" ### BATCH INFO: servo goout issued \n");
}
else
{
$trackCmd = command("servo,goin,0");
info(" ### BATCH INFO: servo goin issued \n");
}


$sourceName = $1 ;
$source = gts($sourceName);

if ($source ne "") 
{
#load source_name field
	$name = [$source getSource];
        loadProperty("source_name,$name");
	info("source name = $name");
	$ra = [$source getRa];
	info("ra = $ra");
	$dec = [$source getDec];
	info("dec = $dec ");
	$epoch = [$source getEpoch];
	info("epoch = $epoch" );

	$trackCmd = command("servo,trackobject,$name,$ra,$dec,$epoch");
	if ($trackCmd ne "") {
		info("trackobject issued with seq $trackCmd ");	
		$trackresult = waitforCmdCompletion( $trackCmd ,10);
		if ($trackresult ne "") {
			info("command completion result =  $trackresult ");
			$trackstatus = getCommandStatus($trackCmd);
			info("command completed with status $trackstatus");
			$trackstatusint = getCommandStatusInt($trackCmd);
			info("command completed with status int $trackstatusint");
                        info("### INFO : $name TRACKING");

                        $az_trkerr = getProperty("azTrackingErr");
                        $el_trkerr = getProperty("elTrackingErr");

                        while ( ( $az_trkerr > 20.0 ) || ( $el_trkerr > 20.0) ) {
                            info("### INFO : batch_tracksource : Moving towards target\n");
                            $az_trkerr = getProperty("azTrackingErr");
                            $el_trkerr = getProperty("elTrackingErr");
                            sleep(3000);
                        }
		}
	}
}
else {
	error("### ERROR - batch_tracksource : Source not found");
}

}


#-------------------------------------------------------------------#

#
#  Template : Pointing scan
#  batch_pointing(sourcename, scanType, AZ/RA_rate in deg/minute, EL/DEC_rate in deg/minute, scan_length in degree)
#  batch_pointing("string1", "string2", "float1", "float2", "int")  
#  e.g. for elevation scan - batch_pointing("CYGA","AZEL","0.0","0.5","10.0");
#

sub batch_pointing
{
  @scanStr = @("AZEL", "RADEC" );
  $sourceName  = $1 ; 
  $scanType    = $2 ;
  $Rate1       = $3 ;
  $Rate2       = $4 ;
  $scanLength  = $5 ;
  
$srvcrdvar = getProperty("srvcrd");
if( $srvcrdvar == 1 )
{
$trackCmd = command("servo,goout,1");
info(" ### BATCH INFO: servo goout issued \n");
}
else
{
$trackCmd = command("servo,goin,0");
info(" ### BATCH INFO: servo goin issued \n");
}

$trackCmd = command("servo,hold,B");

$source = gts($sourceName);

 if ($source ne "") {
#load source_name field
	#info("$source");
	$name = [$source getSource];
        loadProperty("source_name,$name");
	info("source name = $name");
	$ra = [$source getRa];
	info("ra = $ra");
	$dec = [$source getDec];
	info("dec = $dec ");
	$epoch = [$source getEpoch];
	info("epoch = $epoch" );
	$trackCmd = command("servo,trackobject,$name,$ra,$dec,$epoch");
	if ($trackCmd ne "") {
		info("trackobject issued with seq $trackCmd ");	
		$trackresult = waitforCmdCompletion( $trackCmd ,10);
		if ($trackresult ne "") {
			info("command completion result =  $trackresult ");
			$trackstatus = getCommandStatus($trackCmd);
			info("command completed with status $trackstatus");
			$trackstatusint = getCommandStatusInt($trackCmd);
			info("command completed with status int $trackstatusint");
                        info(" $name TRACKING ");

                        $az_trkerr = getProperty("azTrackingErr");
                        $el_trkerr = getProperty("elTrackingErr");

                        while ( ( $az_trkerr > 20.0 ) || ( $el_trkerr > 20.0) ) {
                            info("### INFO : batch_tracksource : Moving towards target\n");
                            $az_trkerr = getProperty("azTrackingErr");
                            $el_trkerr = getProperty("elTrackingErr");
                            sleep(3000);
                        }
		}
	}
}
else {
	error("### ERROR - batch_pointing : source not found");
        return ;
} 

     if( $scanType eq @scanStr[0] ) {
        $scancmd = command("servo,scan,$Rate1,$Rate2,0.0,0.0,$scanLength");
     } else if( $scanType eq @scanStr[1] ) {
        $scancmd = command("servo,scan,0.0,0.0,$Rate1,$Rate2,$scanLength");
     } else {
        error("### ERROR - batch_pointing : Scan-Type $scanType invalid..\n");
        return ;
     }
     
     info( "### INFO Scan $scanType on $sourceName for $scanLength");
     if ($scancmd ne "") {
		info("scan  issued with seq $scancmd ");	
		$cmdresult = waitforCmdCompletion( $scancmd ,10);
		if ($cmdresult ne "") {
			info("command completion result =  $cmdresult ");
			$cmdstatus = getCommandStatus($scancmd);
			info("command completed with status $cmdstatus");
			$cmdstatusint = getCommandStatusInt($scancmd);
			info("command completed with status int $cmdstatusint");
                        info(" $name SCANING FOR $scanLength MINUTES");
                     #  batchsleep($scanLength);
		}
     }
     showTime();
}

#-------------------------------------------------------------------#

# Record Backend Data
# Syntax : recordData("<int>") where 'int' in second 

 sub batch_recorddata
 {
   # assuming that if previous scan running
      $dascmd = command("backend,stopdas");

      $recordTime = $1;
  #
  #   To load scan-type Niruj will provide input
  #   loadProperty("scantype,$2");
  # 
      $dascmd = command("backend,strtdas");
      batchsleep($recordTime);
      $dascmd = command("backend,stopdas");
 }

# -----------------------------------------------------------------------------------------------------
# batch file to execute pointing scan in continuum/spectral mode by slewing in AZ-EL or RA-DEC across the
# object 
# $ April 29,2014,  Version 1.0, JPK $
# ----------------------------------------------------------------------------------------------------
# Batch Execution starts from here

batch_defaultset("1390");
batch_setlo("1330000");
batch_noise("OFF");

for ( $jj = 1 ; $jj < 50 ;  $j++)
{

batch_tracksource("crab");
batch_recorddata("300");
batch_pointing("CRAB","AZEL","0.0","0.5","10.0");
batch_recorddata("1260");

batch_tracksource("crab");
batch_recorddata("300");
batch_pointing("CRAB","AZEL","0.5","0.0","10.0");
batch_recorddata("1260");

}
