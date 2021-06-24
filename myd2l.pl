

use strict;
use warnings;

use AI::MXNet::AutoGrad qw(autograd);
use AI::MXNet qw(np);
use AI::MXNet qw(npx);
use AI::MXNet::Gluon qw(gluon);
use AI::MXNet qw(nd);
use AI::MXNet qw(mx);
use PDL::IO::Pic;
use AI::MXNet::Base;
use AI::MXNet::NDArray
use Data::Dump qw(dump);
use Data::Dumper;

#-----------------------------------------------------------------------------------------#
#3.6. Implementation of Softmax Regression from Scratch

my $batch_size = 256;

my $train_data = gluon->data->DataLoader(
    gluon->data->vision->FashionMNIST('./data', train=>1, transform => \&transformer),
    batch_size=>$batch_size, shuffle=>1, last_batch=>'discard'
);

my $val_data = gluon->data->DataLoader(
    gluon->data->vision->FashionMNIST('./data', train=>0, transform=> \&transformer),
    batch_size=>$batch_size, shuffle=>0
);

#-----------------------------------------------------------------------------------------#
#3.6.1. Initializing Model Parameters

my $num_inputs = 784;
my $num_outputs = 10;


#Draw random samples from a normal (Gaussian) distribution.
#npy.random.normal

#loc Mean (“centre”) of the distribution.
#scalef Standard deviation (spread or “width”) of the distribution. Must be non-negative.
my $W = nd->random->normal(0, 0.01, shape=>[$num_inputs, $num_outputs])->aspdl
print $W

my $b = mx->nd->zeros([$num_outputs])->aspdl
print $b

#Attach gradient to x
# • It allocates memory to store its gradient, which has the same shape as x.
# • It also tell the system that we need to compute its gradient

$W->attach_grad()
p $W->grad()->aspdl

$b->attach_grad()
p $b->grad()->aspdl

#-----------------------------------------------------------------------------------------#
#3.6.2. Defining the Softmax Operation
my $X = mx->nd->array([[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]])

print $X->sum(0, keepdims => 1)->aspdl
print $X->sum(1, keepdims => 1)->aspdl

sub softmax {
    my($X) = @_;
    my $X_exp = exp($X);
    #my $X_exp = mx->nd->exp($X); por que mx->nd->?
    my $partion = $X_exp->sum(0, keepdims => 1);
    return $X_exp / $partion;
}

mx->random->seed(42); #Fix the seed for reproducibility: npx.random.seed(42) ????????????
$X = nd->random->normal(0, 1, shape=>[2, 5])
my $X_prob = softmax($X)
print $X_prob, $X_prob->sum(1)

#-----------------------------------------------------------------------------------------#
#3.6.3. Defining the Model
#implement the softmax regression model.

sub net{
    my($X) = @_;
    #$r=$X->aspdl->reshape([-1, 10]);
    print $r=$X->reshape([-1, 10])->aspdl;
    #return softmax(mx->nd->dot($X->reshape([-1, $W->shape->(0)]), $W) + $b);
    return softmax(mx->nd->dot($X->reshape([-1, @{$W->shape}[0]]), $W) + $b);
}

#-----------------------------------------------------------------------------------------#
#3.6.4. Defining the Loss Function

#SOLUCION MEJOR ENCONTRADA. PONER EL VECTOR [0, 1] EN UNA VARIABLE
my $y = mx->nd->array([0, 2])
my $y_hat = mx->nd->array([[0.1, 0.3, 0.6], [0.3, 0.2, 0.5]])
my $x = mx->nd->array([0, 1]) #para ----------- y_hat[[0, 1], y]
p $y_hat->slice([$x, $y)->aspdl


sub cross_entropy{
  my($y_hat, $y)= @_;
  $a=mx->nd->_arange($y_hat->len);
  return -log($y_hat->slice([$a, $y]));
}

print "cross_entropy=", cross_entropy($y_hat, $y)->aspdl, "\n";#J

sub sgd{#@save
my($params,$lr,$batch_size)=@_;
my $params2=$params;
for ($i=0;$i<$params->size();$i++){
$params2[$i]=$params2[$i]-$lr*$params2->grad()/$batch_size;
}
}


my $lr=0.1
sub updater{
  my$batch_size = @_;
  return sgd(\$w, \$b, $lr, $batch_size);
}


#-------------L       I       B       R       E       I       A       S----------------------------------------------------------------------------#
#3.6.5. Classification Accuracy
#1 accuracy -------------------------------------------------------------------------------

sub accuracy{
  my($y_hat, $y)=@_;
  if ($y_hat->aspdl->shape->len > 1 && $y_hat->aspdl->shape->slice(0) > 1)#sin el dump, el orden de filas y columnas, en shape, cambia. Mucho ojo!
  {
    $y_hat=AI::MXNet::NDArray->argmax($y_hat, { axis => 1 });
  }
  my $cmp = $y_hat->astype($y->dtype) == $y;
  return $cmp->astype($y->dtype)->sum->astype('float32')->aspdl->at(0);#J
  #return $cmp->astype($y->dtype)->sum, dtype=>'float';
  #$l=$cmp->astype($y->dtype)->sum;
  #$data = $cmp->astype($y->dtype)->sum->asStype('float32')/255;
  #return $data;
  #PARECE QUE NO ES NECESARIO LO DE FLOAT322222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
}

print ("accuracy=", accuracy($y_hat, $y) / $y->len, "\n");#J

pdl> p $m=(accuracy($y_hat, $y) / $y->len)->aspdl
[0.5]

pdl> p $m->dtype
float32

pdl> $c=($cmp->astype($y->dtype)->sum->aspdl)->float

pdl> p $c->dtype
float32


#2 evaluate_accuracy -------------------------------------------------------------------------------

sub evaluate_accuracy{
  my($net, $data_iter)=@_;
  #my $metric = Accumulator(2);#?????
  my $metric = Accumulator->new(2);#J
  for my $X ($data_iter) {
   $metric->add(accuracy(net($X), $y), $y->size)
  }
  return metric->slice(0) / metric->slice(1)
}

#Accumulator
#revision de add y slice

#3 Accumulator -------------------------------------------------------------------------------
package Accumulator #https://www.perltutorial.org/perl-oop/
use strict;
use warnings;
sub new{
  my ($self,$n) = @_;
  $self->{data} = [0, 0] * $n;
}

sub add{
   my ($self,*args) = @_;#???args
   my $a=zip @$self->{data}, $args
   $self->{data} = [$a + $b for $a, $b (@a)];#https://stackoverflow.com/questions/38345/is-there-an-elegant-zip-to-interleave-two-lists-in-perl-5
}

sub reset{
   my ($self) = @_;
   $self->{data} = [0, 0] * $self->{data}->len;
}

sub __getitem__{
   my ($self,$idx) = @_;
   #my $self = shift;
   return $self->{data}->slice($idx)
}


#4 train_epoch_ch3 -------------------------------------------------------------------------------

sub train_epoch_ch3{
  my($net, $train_data, $loss, $updater);
  #$metric=Accumulator(3)#????
  my $metric = Accumulator->new(3);#J
  if (isinstance($updater, gluon->Trainer))#????isinstance
    {$updater = $updater->step}#????
  #for my $X ($train_iter) {#????
  print "Start training\n";#J
  my $l;
  while(defined(my $batch = <$train_iter>)){#J
    my $X = $batch->[0];#J
    my $y = $batch->[1]->astype('float32');#J
    autograd->record(sub {#alex's code
      $y_hat = net($X);#Alex's code
      $l = $loss->($y_hat, $y);#Alex's code
    });
    $l->backward()
    #$updater->$X->aspdl->shape->slice(0);
    $updater->(@{$X->shape}[0]);
    #$metric->add($l->sum, accuracy($y_hat, $y), $y->size);#????add
    $metric->add(\@{[ $l->sum->astype('float32')->aspdl->at(0), accuracy($y_hat, $y), $y->size ]});#J
  }
  print $metric->getitem($_-1), " " for (1 .. 3); print "\n";#J
  #return $metric->slice(0) / $metric->slice(2), $metric->slice(1) / $metric->slice(2);
  return ($metric->getitem(0) / $metric->getitem(2), $metric->getitem(1) / $metric->getitem(2));#J
}
