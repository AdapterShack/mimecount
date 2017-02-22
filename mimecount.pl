#!/usr/bin/perl

open FIND, "find . -type f |";

%totals = ();

while(<FIND>) {

        chomp;

        my $size = (stat $_)[7];

        my $type = `file -b --mime-type "$_"`;

        chomp $type;

        # force certain types when standard "file" gets it weird..
        /\.js$/ and $type = "application/javascript";
        /\.json$/ and $type = "application/json";
        /\.css$/ and $type = "text/css";
        /\.woff2?$/ and $type = "application/woff";
        /\.eot$/ and $type = "application/vnd.ms-fontobject";

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
