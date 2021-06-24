if ($y_hat->aspdl->shape->len > 1 && $y_hat->aspdl->shape->slice(0) > 1)

if (@{$y_hat->shape}[0] > 1 && @{$y_hat->shape}[1] > 1)



$y_hat=AI::MXNet::NDArray->argmax($y_hat, { axis => 1 });

$y_hat = $y_hat->argmax(axis => 1);


return $cmp->astype($y->dtype)->sum
return $cmp->astype($y->dtype)->sum->astype('float32')->aspdl->at(0);

#CLASE, CREAR UNA

>>> metric = Accumulator(2);#?????
my $metric = Accumulator->new(2);



>>> if isinstance(updater, gluon.Trainer):
if (blessed($updater) && $updater->isa('gluon::Trainer')){#https://stackoverflow.com/questions/45376119/perl-is-object-instance-of-class


$metric->add($l->sum, accuracy($y_hat, $y), $y->size);#????add
$metric->add(\@{[ $l->sum->astype('float32')->aspdl->at(0), accuracy($y_hat, $y), $y->size ]});#J
#\@???

return $metric->slice(0) / $metric->slice(2), $metric->slice(1) / $metric->slice(2);
return ($metric->getitem(0) / $metric->getitem(2), $metric->getitem(1) / $metric->getitem(2));




El bless pa que sirve?
