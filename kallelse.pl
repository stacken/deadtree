#!/usr/bin/env perl
use Time::Piece;

my $t = Time::Piece->new();
$memyear=$t->year - 2;

$fingerfile="/tmp/out/finger.txt";
open(BET,$fingerfile) || die;
while (defined($_=<BET>)) {
	chop;
	@record=split(/;/);
	$efternamn=$record[0];
	$fornamn=$record[1];
	$careof=$record[4];
	$avdelning=$record[5];
	$org=$record[6];
	$adress3=$record[7];
	$postnr=substr($record[8],0,6);
	$postort=substr($record[8],8);
	$land=$record[9];
	$distribution=$record[10];
	$user=$record[14];
	$year=$record[16];
	$utdate=$record[18];
	$status=$record[19];

	if ($efternamn ne '' && ($year >= $memyear || $status =~ m/Hedersmedlem/i || $status =~ m/Ny/i)) {
		if ($status !~ m/Epost.?[Kk]allelse/i && $status !~ m/[Ff]el.?[Aa]dd?ress/i && $status !~ m/Slutat/i && $utdate =~ /^\s*$/ ) {
			print $fornamn." ".$efternamn."|".$careof."|".$adress3."|".$postnr."|".$postort."\n";
		}
	}
}
close(BET);

