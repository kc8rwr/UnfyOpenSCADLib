# UnfyOpenSCADLib

This is a library of re-usable OpenSCAD code intended for designing 3d printed devices.
It includes but is not limited to:
* Fasteners (SAE + Metric, Bolts of various head types, nuts, washers, heatset inserts, etc)
* Mathematical functions
* Bezier curves
* Shapes with fillets
* Pop-in switch cutouts
* Servo mounts
* 3d printer parts
* Random parts

Click [here](https://kc8rwr.github.io/UnfyOpenSCADLib/) for full documentation.

This consists of several files, divided by topic. It can be imported into your project as a submodule if you are using Git or just downloaded into a folder inside it if not.

Each file should contain functions and modules which may be imported into your project via the USE statement. They should also contain root code such that if you open the file itself in OpenSCAD and enable the customizer window you can select a module or a function to demonstrate and try changing the arguments passed to it via the customizer. For this reason one should only import these into a project using USE, not INCLUDE.

_Some files do not yet have this 'preview' code. This will be added soon._

It is not necessary to import all the files but rather just the ones one wishes to use. Some do rely on one another but where this is the case they will include their own USE statements to import what is needed.

Documentation is also built via [openscad-docsgen](https://github.com/BelfrySCAD/openscad_docsgen?tab=readme-ov-file "I recommend learning and using this tool"). Of course one may run this tool to generate documents from their own working tree however documents generated for the latest UnfyOpenSCADLib pushed to GitHub may be found at [Github Pages](https://kc8rwr.github.io/UnfyOpenSCADLib/).

_Not all files have docsgen comments yet and therefore not all show up in this documentation. This will be fixed shortly._

Because OpenSCAD does not allow for classes or namespaces every module and function name should be prefixed with the characters "unf_". This way they will be unlikely to conflict with other libraries one might wish to use.

*This might not be consistent yet, with some prefixed by "unfy_" instead. This will be changing soon.*

Much attention has been placed on giving the user choices, such as choosing different models of switches or sizes of fasteners. Fastener sizes are specified with natural strings. For example metric sizes are "M_" such as "M4" for an M4 bolt. Numbered SAE sizes are specifed "#_" such as "#6" for a Number 6 screw. Inch sizes are just the number such as "0.25" for a 1/4 inch screw. Numbers may even contain a "/" for division so "1/4" should also work for a 1/4 inch screw.

The idea is to try to design 3d printable projects where the user may easily chose the vitamins (non 3d-printed parts) that they have on hand or that are easily available in their own part of the world. A user of the library can make a number of parts or fasteners selectable via a dropdown in the customizer and then pass that to the various modules so the resulting design adapts for the user's choices. This includes for example functions that take the part model# or the fastener size and answer questions like "how wide is this at it's widest part" so that other parts of the design may be actively shifted to account for different user selections.

Early on there was also a focus on minimizing post-processing. To this end the fasteners library can generate bolt holes with a distortion on top so that when the overhang is printed and droops it cancels out producing a more round hole. The fasteners file includes a part to print with several holes with various parameters for the distortion. The idea was that designers using the library would include this part as an option to print in their own design. The end user would then pick the best hole and enter it's parameters into the customizer. This way variances between printers, slicers and materials could be accounted for. Unfortunately, since OpenSCAD modules do not "know" the objective orientation in which they are being rendered this only works if the design is printed in the same orientation it is designed in. No flipping things in the slicer. (Is the module within any rotate(){} modules?) This effort has been sidelined and so it only exists currently for bolt holes and not other cutouts. Maybe this will come back in the future. Maybe not.
