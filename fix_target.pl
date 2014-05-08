#!/usr/bin/perl

my $line = 0;         
my $target_line = 0;

my $infile  = $ARGV[0];  # file to read
my $outfile = $ARGV[1];  # file to write
my $module  = $ARGV[2];  # ArtifactId to search for

open(IN, $infile);

while (<IN>) {
  $line++;
  if (/<artifactId>$module/) {
    $target_line = $line;
  }
}

close(IN);
open(OUT, ">$outfile");
open(IN, $ARGV[0]);

for ($x = 0; $x < $target_line; $x++) {
  $_ = <IN>;
  print OUT $_;
}

$_ = <IN>;
s#(<version>[0-9]+\.[0-9]+)[^<]+(</version>)#$1-SNAPSHOT$2#g;
print OUT $_;

while (<IN>) {
  print OUT $_;
}

close(IN);
close(OUT);

