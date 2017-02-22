#!/usr/bin/perl

open FIND, "find . -type f |";

%totals = ();

while(<FIND>) {

        chomp;

        my $size = (stat $_)[7];

        my $type = `file -b --mime-type "$_"`;

        chomp $type;

        print "$_\t$size\t$type\n";

        $totals{$type} += $size;

        $type =~ s/\/.+/\/\*/;

        $wtotals{$type} += $size;


}

print "\n\nSummary:\n\n";

foreach my $type (keys %totals) {

        print $type, "\t", $totals{$type}, "\n";

}

print "\n\n";

foreach my $type (keys %wtotals) {

        print $type, "\t", $wtotals{$type}, "\n";

}
