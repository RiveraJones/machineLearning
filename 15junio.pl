
pdl> p $pdlx = xvals(51)
[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50]
pdl> ^Cp $pdlx = xvals(51) / 10
Ctrl-C detected
pdl> p $pdlx = xvals(51) / 10
[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5]
pdl> $w = gpwin('x11', enhanced=>);
Undefined subroutine &main::gpwin called

pdl> $w = gpwin('x11', enhanced=>1);
Undefined subroutine &main::gpwin called

pdl> $w = gpwin( 'x11' , enhanced=>1);
Undefined subroutine &main::gpwin called

pdl> $w = gpwin( 'x11', enhanced=>1);
Undefined subroutine &main::gpwin called

pdl> $w = gpwin( 'x11', enhanced=>1);
Undefined subroutine &main::gpwin called

pdl> use PDL::Graphics::Gnuplot;

pdl> use PDL::Constants;

pdl> $w = gpwin( 'x11' , enhanced=>1);
Undefined subroutine &main::gpwin called

pdl> use PDL::Graphics::Gnuplot;

pdl> $w = gpwin( 'x11' , enhanced=>1);

pdl> $w->plot(legend=>"x^2", with=>"lines", $pdlx, $pdlx**2);

pdl> p $pdlx**2;
[0 0.01 0.04 0.09 0.16 0.25 0.36 0.49 0.64 0.81 1 1.21 1.44 1.69 1.96 2.25 2.56 2.89 3.24 3.61 4 4.41 4.84 5.29 5.76 6.25 6.76 7.29 7.84 8.41 9 9.61 10.24 10.89 11.56 12.25 12.96 13.69 14.44 15.21 16 16.81 17.64 18.49 19.36 20.25 21.16 22.09 23.04 24.01 25]
pdl> $w->plot(legend=>"3x^2 -4x", with=>"lines", $pdlx, 3 * $pdlx ** 2 - 4 * $pdlx );

pdl> $->replot(legend=>"Tangent line (x=1)", with=>"points", $pdlx, 2*$pdlx-3)
Undefined subroutine &main::replot called

pdl> $->replot(legend=>"Tangent line (x=1)", with=>"points", $pdlx, 2 * $pdlx - 3)
Undefined subroutine &main::replot called

pdl> w$->replot(legend=>"Tangent line (x=1)", with=>"points", $pdlx, 2 * $pdlx - 3)

#Can't locate object method "w" via package "0" (perhaps you forgot to load "0"?)

pdl> $w->replot(legend=>"Tangent line (x=1)", with=>"points", $pdlx, 2 * $pdlx - 3)

pdl> $w->options(grid=>["xtics", "ytics"])

pdl> $w->replot(legend=>"Tangent line (x=1)", with=>"points", $pdlx, 2 * $pdlx - 3)

pdl> $w->replot()

pdl> $w->replot(legend=>"Tangent line (x=1)", with=>"lines", $pdlx, 2 * $pdlx - 3)

pdl> $w->replot(legend=>"Tangent line (x=1)", with=>"points", $pdlx, 2 * $pdlx - 3)

pdl> $w->replot(legend=>"Tangent line (x=1)", with=>"points", $pdlx, 2 * $pdlx - 3)

pdl> $w->options(xlabel=>"x")

pdl> $w->replot()

pdl> $w->replot()

pdl> $w->options(ylabel=>"f(x)")

pdl> $w->replot()

pdl> $w->replot(key=>"top center")

pdl> $w->replot(key=>"top center spacing 1.3 height 1.5")

pdl> $w->replot(legend=>"Tangent line (x=1)", with=>"points", linecolor=>'orange' $pdlx, 2 * $pdlx - 3)
Scalar found where operator expected at (eval 199) line 4, near "'orange' $pdlx"
	(Missing operator before  $pdlx?)
syntax error at (eval 199) line 4, near "'orange' $pdlx"

pdl> $w->replot(legend=>"Tangent line (x=1)", with=>"lines", linecolor=>'orange' $pdlx, 2 * $pdlx - 3)
Scalar found where operator expected at (eval 200) line 4, near "'orange' $pdlx"
	(Missing operator before  $pdlx?)
syntax error at (eval 200) line 4, near "'orange' $pdlx"

pdl> $w->replot(legend=>"Tangent line (x=1)", with=>"lines", linecolor=>'orange', $pdlx, 2 * $pdlx - 3)

pdl> $w->replot(legend=>"Tangent line (x=1)", with=>"lines", linecolor=>'orange', linetype>2, $pdlx, 2 * $pdlx - 3)
No curve option found that matches ''

 at /usr/local/share/perl5/PDL/Graphics/Gnuplot.pm line 3553.
	PDL::Graphics::Gnuplot::parseArgs(PDL::Graphics::Gnuplot=HASH(0x556c79b5fe68), "legend", "3x^2 -4x", "with", "lines", PDL=SCALAR(0x556c7a55e4f8), PDL=SCALAR(0x556c7aec3480), "legend", ...) called at /usr/local/share/perl5/PDL/Graphics/Gnuplot.pm line 2824
	PDL::Graphics::Gnuplot::plot("legend", "3x^2 -4x", "with", "lines", PDL=SCALAR(0x556c7a55e4f8), PDL=SCALAR(0x556c7aec3480), "legend", "Tangent line (x=1)", ...) called at /usr/local/share/perl5/PDL/Graphics/Gnuplot.pm line 4053
	PDL::Graphics::Gnuplot::replot(undef, "legend", "Tangent line (x=1)", "with", "lines", "linecolor", "orange", "", ...) called at (eval 202) line 4
	main::__ANON__() called at /usr/local/bin/perldl line 700
	eval {...} called at /usr/local/bin/perldl line 700
	main::eval_and_report("\$w->replot(legend=>\"Tangent line (x=1)\", with=>\"lines\", linec"...) called at /usr/local/bin/perldl line 636
	main::process_input() called at /usr/local/bin/perldl line 656
	eval {...} called at /usr/local/bin/perldl line 656

pdl> $w->replot(legend=>"Tangent line (x=1)", with=>"lines", linecolor=>'orange', linetype>2,, $pdlx, 2 * $pdlx - 3)
No curve option found that matches ''

 at /usr/local/share/perl5/PDL/Graphics/Gnuplot.pm line 3553.
	PDL::Graphics::Gnuplot::parseArgs(PDL::Graphics::Gnuplot=HASH(0x556c79b5fe68), "legend", "3x^2 -4x", "with", "lines", PDL=SCALAR(0x556c7a55e4f8), PDL=SCALAR(0x556c7aec3480), "legend", ...) called at /usr/local/share/perl5/PDL/Graphics/Gnuplot.pm line 2824
	PDL::Graphics::Gnuplot::plot("legend", "3x^2 -4x", "with", "lines", PDL=SCALAR(0x556c7a55e4f8), PDL=SCALAR(0x556c7aec3480), "legend", "Tangent line (x=1)", ...) called at /usr/local/share/perl5/PDL/Graphics/Gnuplot.pm line 4053
	PDL::Graphics::Gnuplot::replot(undef, "legend", "Tangent line (x=1)", "with", "lines", "linecolor", "orange", "", ...) called at (eval 203) line 4
	main::__ANON__() called at /usr/local/bin/perldl line 700
	eval {...} called at /usr/local/bin/perldl line 700
	main::eval_and_report("\$w->replot(legend=>\"Tangent line (x=1)\", with=>\"lines\", linec"...) called at /usr/local/bin/perldl line 636
	main::process_input() called at /usr/local/bin/perldl line 656
	eval {...} called at /usr/local/bin/perldl line 656

pdl>
pdl>
pdl>
pdl>
pdl>
pdl>
pdl>
pdl>
pdl>
pdl>
pdl>
pdl>
pdl>
pdl>
pdl>
pdl>
pdl>
pdl>
pdl> $svg = gpwin('svg', enhanced=>1)

pdl> $svg->plot(legend=>"x^2", with=>"lines", $pdlx, $pdlx**2)
INFO: Plotting to 'Plot-1.svg'
 at (eval 205) line 4.
