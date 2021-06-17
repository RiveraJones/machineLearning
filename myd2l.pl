

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

$y = mx->nd->array([0, 2])
$y_hat = mx->nd->array([[0.1, 0.3, 0.6], [0.3, 0.2, 0.5]])
$y_hat([[0, 1], [$y]])


 $$y_hat = mx->nd->array([1, 2, 4, 8], [$y])
