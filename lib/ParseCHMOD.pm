package ParseCHMOD;

use 5.006;
use strict;
use warnings FATAL => 'all';

use Exporter qw(import);
our @EXPORT_OK = qw(parse_bits parse_file_listing);

our $VERSION = '0.01';

our $prem_e = {rwx=>'Read, Write & Execute',
				rw=>'Read & Write',
				rx=>'Read & Execute',
				r =>'Only Read',
				wx=>'Write & Execute',
				w =>'Only Write',
				x =>'Only Execute',
				'-'=>'do nothing to'};

our $prem_fs = {rwx=>'rwx',
				rw=>'rw-',
				rx=>'r-x',
				r =>'r--',
				wx=>'-wx',
				w =>'-w-',
				x =>'--x',
				'-'=>'---'};					
our $bits = {7=>'rwx',
			6=>'rw',
			5=>'rx',
			4=>'r',
			3=>'wx',
			2=>'w',
			1=>'x',
			0=>'-',
			};
sub new {
    my $class = shift;
    my $self = bless {}, $class;
    
    return $self;
}

sub parse_bits {
    my $self = shift;
	my ($chmod ) = @_;
    
    my @chmod_bits = split("",$chmod);
    
    printf "Owner can %s the file!\n",$prem_e->{$bits->{$chmod_bits[0]}};
    printf "Group members can %s the file!\n",$prem_e->{$bits->{$chmod_bits[1]}};
    printf "Others can %s the file!\n",$prem_e->{$bits->{$chmod_bits[2]}};
    printf "and on the file system it looks like: %s%s%s \n\n",$prem_fs->{$bits->{$chmod_bits[0]}},$prem_fs->{$bits->{$chmod_bits[1]}},$prem_fs->{$bits->{$chmod_bits[2]}};
   
    
}

sub parse_file_listing {
    my $self = shift;
	my ($perms ) = @_;
 
	my $type=$file_type->{substr($perms ,0,1)};
	printf "The listing '%s' is a \n",$perms;
	my $fname =  substr($perms,49,length($perms)-49);
    printf "%s called %s\n",$type,$fname;
    printf "is hidden\n"
		if (substr($fname,0,1) eq '.' and $type eq 'File');
    printf "is owned by %s\n",substr($perms ,14,8);
    printf "is in group %s\n",substr($perms ,22,5);
    printf "takes up %s bytes \n",substr($perms ,27,8);
    printf "last updated on %s \n",substr($perms ,35,13);
    printf "Owner can %s the %s!\n",$prem_e->{$fs_perm->{substr($perms ,1,3)}},$type;
   
    printf "Group members can %s the %s!\n",$prem_e->{$fs_perm->{substr($perms ,4,3)}},$type;
    
    printf "Others can %s the %s!\n",$prem_e->{$fs_perm->{substr($perms ,7,3)}},$type;
    printf "the chmod of this in bits would look like this: chmod %s%s%s %s\n\n",$fs_bits->{$fs_perm->{substr($perms ,1,3)}},$fs_bits->{$fs_perm->{substr($perms ,4,3)}},$fs_bits->{$fs_perm->{substr($perms ,7,3)}},$fname;
  }
