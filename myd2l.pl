

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

$batch_size = 256;

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

$num_inputs = 784;
$num_outputs = 10;


#Draw random samples from a normal (Gaussian) distribution.
#npy.random.normal

#loc Mean (“centre”) of the distribution.
#scalef Standard deviation (spread or “width”) of the distribution. Must be non-negative.
$W = nd->random->normal(0, 0.01, shape=>[$num_inputs, $num_outputs])->aspdl
p $W

$b = mx->nd->zeros([$num_outputs])->aspdl
p $b

#Attach gradient to x
# • It allocates memory to store its gradient, which has the same shape as x.
# • It also tell the system that we need to compute its gradient

$W->attach_grad()
p $W->grad()->aspdl

$b->attach_grad()
p $b->grad()->aspdl

#-----------------------------------------------------------------------------------------#
#3.6.2. Defining the Softmax Operation
$X = mx->nd->array([[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]])

p $X->sum(0, keepdims => 1)->aspdl
p $X->sum(1, keepdims => 1)->aspdl

sub softmax {
    my($X) = @_;
    $X_exp = exp($X);
    $partion = $X_exp->sum(0, keepdims => 1);
    return $X_exp / $partion;
}

$X = nd->random->normal(0, 1, shape=>[2, 5])
$X_prob = softmax($X)
$X_prob, $X_prob->sum(1)

#-----------------------------------------------------------------------------------------#
#3.6.3. Defining the Model
#implement the softmax regression model.

sub net{
    my($X) = @_;
    return softmax(mx->nd->dot($X.reshape([-1, $W.shape[0]]), $W) + $b)
}

#-----------------------------------------------------------------------------------------#
#3.6.4. Defining the Loss Function

my $y = mx->nd->array([0, 2])
my $y_hat = mx->nd->array([[0.1, 0.3, 0.6], [0.3, 0.2, 0.5]])
###########################################################################################################
$y_hat([[0, 1], [$y]])
###########################################################################################################
p $y_hat->slice([[0, 1], [0, 2]])->aspdl
#no he hallado la forma de poner dentro de ->slice una variable($y). Por lo que he puesto a mano [0,2]=$y, sin usar la variable.

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

#-------------L       I       B       R       E       I       A       S----------------------------------------------------------------------------#
#3.6.5. Classification Accuracy

sub accuracy{
  my($y_hat, $y)=@_;
  if ($y_hat->aspdl->shape->len > 1 && $y_hat->aspdl->shape->slice(0) > 1)#sin el dump, el orden de filas y columnas, en shape, cambia. Mucho ojo!
  {
    $y_hat=AI::MXNet::NDArray->argmax($y_hat, { axis => 1 });

  }

  return
}


my $e= dump $y_hat->shape
p $e->len

$fpdl=y_hat->shape
(dump $y_hat->shape)->len



print Dumper($X->moveaxis(0, 1)->shape)

print Dumper($y_hat->shape)->len

$s=mx->nd->(Dumper($y_hat->shape))

#conflicto de formato shape dentro de len. Necesita un array, empero le doy algo distinto con el dump.
p dump ($y_hat->shape)->len
p $y_hat->aspdl->shape->len
p $y->aspdl->shape;
#lo que me devuelve shape es un PDL, y para extraer el primer o segundo objeto de [3 2] mecesito que sea un array
