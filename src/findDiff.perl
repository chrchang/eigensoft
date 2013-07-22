#!/usr/bin/perl
use strict;


unless ( @ARGV == 2 )  {
  print "usage:  thisprog.perl < dir1 > < dir2 >\n";
  exit(1);
}
my $dir1 = $ARGV[0];
my $dir2 = $ARGV[1];

# find all files in both directories
opendir(DIR,$dir1);
my @D1 = readdir(DIR);
closedir(DIR);

opendir(DIR,$dir2);
my @D2 = readdir(DIR);
closedir(DIR);

my %files = ();
foreach my $f (@D1)  {
  chomp($f);
  $files{$f} = 1;
}

foreach my $f (@D2)  {
  chomp($f);
  if ( exists $files{$f} )  {
    $files{$f} = 2;
  }
}

foreach my $f (keys %files)  {
  unless ( $files{$f} == 2 )  {
    delete $files{$f};
  }
}

# only keep .c files
foreach my $f (keys %files)  {

  unless ( $f =~ m/.*\.c/ )  {
    delete $files{$f};
  }
}


foreach my $f (keys %files)  {
  system("diff -bw $dir1/$f $dir2/$f >$f.diff");
  printf "%s\n", $f;
}



