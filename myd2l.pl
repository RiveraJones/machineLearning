use strict;
use warnings;
use AI::MXNet qw(mx);
use AI::MXNet::Gluon qw(gluon);
use AI::MXNet::AutoGrad qw(autograd);
use AI::MXNet::Gluon::NN qw(nn);
use AI::MXNet::Base;
use Getopt::Long qw(HelpMessage);
use Time::HiRes qw(time);
use PDL::IO::Pic;

my $batch_size = 64;
my $nz  = 100;
my $ngf = 64;g
my $ndf = 64;
my $nepoch = 25;
my $lr =0.0002;
my $beta1 = 0.5;
my $nc = 3;
## change to my $ctx = mx->cpu(); if needed
my $ctx = mx->gpu();

my $train_data = gluon->data->DataLoader(
    gluon->data->vision->MNIST('./data', train=>1, transform => \&transformer),
    batch_size=>$batch_size, shuffle=>1, last_batch=>'discard'
);
