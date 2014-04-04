package ParseCHMOD;

use 5.006;
use strict;
use warnings FATAL => 'all';

use Exporter qw(import);
our @EXPORT_OK = qw(parse_bits parse_permissions);

our $VERSION = '0.01';

our $prem_e = {rwx=>'Read, Write & Execute',
				rw=>'Read & Write',
				rx=>'Read & Execute',
				r =>'Only Read',
				wx=>'Write & Execute',
				w =>'Only Write',
				x =>'Only Execute',
				'-'=>'do nothing to'};
			
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
    
    printf "Group members can %s the file!\n",$prem_e->{$bits->{$chmod_bits[0]}};
    printf "Group members can %s the file!\n",$prem_e->{$bits->{$chmod_bits[1]}};
    printf "Others can %s the file!\n",$prem_e->{$bits->{$chmod_bits[2]}};
    printf "and on the FS %s%s%s.\n,
   
    
}
