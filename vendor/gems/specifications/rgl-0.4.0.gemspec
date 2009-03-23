# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rgl}
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Horst Duchene"]
  s.autorequire = %q{rgl/base}
  s.date = %q{2008-08-26}
  s.description = %q{RGL is a framework for graph data structures and algorithms.  The design of the library is much influenced by the Boost Graph Library (BGL) which is written in C++ heavily using its template mechanism.  RGL currently contains a core set of algorithm patterns:  * Breadth First Search  * Depth First Search   The algorithm patterns by themselves do not compute any meaningful quantities over graphs, they are merely building blocks for constructing graph algorithms. The graph algorithms in RGL currently include:  * Topological Sort  * Connected Components  * Strongly Connected Components  * Transitive Closure * Transitive Reduction * Graph Condensation * Search cycles (contributed by Shawn Garbett)}
  s.email = %q{monora@gmail.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["install.rb", "Rakefile", "ChangeLog", "README", "tests/TestGraph.rb", "tests/TestUnDirectedGraph.rb", "tests/TestTransitivity.rb", "tests/TestTraversal.rb", "tests/TestDot.rb", "tests/TestEdge.rb", "tests/TestDirectedGraph.rb", "tests/TestRdot.rb", "tests/TestCycles.rb", "tests/TestImplicit.rb", "tests/test_helper.rb", "tests/TestGraphXML.rb", "tests/TestComponents.rb", "examples/insel-der-tausend-gefahren.rb", "examples/canvas.rb", "examples/north.rb", "examples/north2.rb", "examples/example.jpg", "examples/module_graph.jpg", "examples/examples.rb", "examples/rdep-rgl.rb", "examples/north", "examples/north/g.10.75.graphml", "examples/north/g.10.0.graphml", "examples/north/g.10.41.graphml", "examples/north/g.10.93.graphml", "examples/north/g.10.7.graphml", "examples/north/g.10.30.graphml", "examples/north/g.10.20.graphml", "examples/north/g.10.89.graphml", "examples/north/g.10.78.graphml", "examples/north/g.10.19.graphml", "examples/north/g.10.86.graphml", "examples/north/g.10.92.graphml", "examples/north/g.10.38.graphml", "examples/north/g.10.14.graphml", "examples/north/g.10.2.graphml", "examples/north/g.10.46.graphml", "examples/north/g.10.72.graphml", "examples/north/g.10.24.graphml", "examples/north/g.10.45.graphml", "examples/north/g.10.88.graphml", "examples/north/g.10.82.graphml", "examples/north/g.10.27.graphml", "examples/north/g.10.31.graphml", "examples/north/g.10.1.graphml", "examples/north/g.10.25.graphml", "examples/north/g.10.71.graphml", "examples/north/g.10.50.graphml", "examples/north/g.12.8.graphml", "examples/north/g.10.91.graphml", "examples/north/g.10.69.graphml", "examples/north/g.10.13.graphml", "examples/north/g.14.9.graphml", "examples/north/g.10.42.graphml", "examples/north/g.10.79.graphml", "examples/north/g.10.39.graphml", "examples/north/g.10.16.graphml", "examples/north/Graph.log", "examples/north/g.10.94.graphml", "examples/north/g.10.68.graphml", "examples/north/g.10.80.graphml", "examples/north/g.10.37.graphml", "examples/north/g.10.61.graphml", "examples/north/g.10.83.graphml", "examples/north/g.10.5.graphml", "examples/north/g.10.11.graphml", "examples/north/g.10.40.graphml", "examples/north/g.10.4.graphml", "examples/north/g.10.90.graphml", "examples/north/g.10.58.graphml", "examples/north/g.10.15.graphml", "examples/north/g.10.8.graphml", "examples/north/g.10.6.graphml", "examples/north/g.10.22.graphml", "examples/north/g.10.9.graphml", "examples/north/g.10.57.graphml", "examples/north/g.10.29.graphml", "examples/north/g.10.85.graphml", "examples/north/g.10.70.graphml", "examples/north/g.10.62.graphml", "examples/north/g.10.17.graphml", "examples/north/g.10.34.graphml", "examples/north/g.10.56.graphml", "examples/north/g.10.12.graphml", "examples/north/g.10.74.graphml", "examples/north/g.10.28.graphml", "examples/north/g.10.60.graphml", "examples/north/g.10.3.graphml", "rakelib/dep_graph.rake", "lib/rgl/enumerable_ext.rb", "lib/rgl/transitiv_closure.rb", "lib/rgl/graphxml.rb", "lib/rgl/condensation.rb", "lib/rgl/connected_components.rb", "lib/rgl/adjacency.rb", "lib/rgl/dot.rb", "lib/rgl/base.rb", "lib/rgl/rdot.rb", "lib/rgl/mutable.rb", "lib/rgl/bidirectional.rb", "lib/rgl/transitivity.rb", "lib/rgl/topsort.rb", "lib/rgl/traversal.rb", "lib/rgl/implicit.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://rgl.rubyforge.org}
  s.rdoc_options = ["--title", "RGL - Ruby Graph Library", "--main", "README", "--line-numbers"]
  s.require_paths = ["lib"]
  s.requirements = ["Stream library, v0.5 or later"]
  s.rubyforge_project = %q{rgl}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby Graph Library}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<stream>, [">= 0.5"])
      s.add_runtime_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<stream>, [">= 0.5"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<stream>, [">= 0.5"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
