#--------------------------------------------------------------------------------------
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

#---------------------------------------------------------------------------------
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

#------------------------------------------------------------------
#  batch_setlo : To set Sigcon LO Frequency
#  Syntax : batch_setlo(INT)  Frequency in KHz for e.g. 1330000

sub batch_setlo
{
  $loval = $1 ;
  $locmd = command("sigcon,set lo,$loval");
  $locmdresult = waitforCmdCompletion( $locmd ,10);
}

#------------------------------------------------------------------------------
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

#-----------------------------------------------------------------------------------
# template : batch_position
# Syntax   : batch_position("azang","elang") Where azang - deg:':" elang - deg: ': "
# e.g. batch_position("102:23:00","80:21:12");
#


sub batch_position
{
  $ang1 = $1 ;
  $ang2 = $2 ;
  
  $stopcmd = command("servo,stoptrack");
  $trackCmd = command("servo,hold,B");

  $postCmd = command("servo,position,B,$ang1, $ang2");

   $az_trkerr = getProperty("azTrackingErr");
   $el_trkerr = getProperty("elTrackingErr");
   
   while ( ( $az_trkerr > 20.0 ) || ( $el_trkerr > 20.0) ) {
       info("### INFO : batch_tracksource : Moving towards target\n");
       $az_trkerr = getProperty("azTrackingErr");
       $el_trkerr = getProperty("elTrackingErr");
       sleep(3000);
   }

}

#-------------------------------------------------------------------
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
# batch file to acquire data with 15m antenna in stationary mode
# object 
# $ April 29,2014,  Version 1.0, JPK $
# ----------------------------------------------------------------------------------------------------
# Batch Execution starts from here

batch_defaultset("1390");
batch_setlo("1330000");
batch_noise("OFF");
batch_position("100:20:00","45:00:00");
batch_recorddata("600");
