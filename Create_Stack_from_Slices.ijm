//Set threshold
threshold = 230;
//Set batch_size/Periodicity
batch_size = 8;

//Set directonary where offsets are saved (must be a directionary that only contains the offsets)
#@ File (style="directory") imageFolder;
dir = File.getDefaultDir;
dir = replace(dir,"\\","/");

files = getFileList(dir);
length = lengthOf(files);

offset = 0;
for (n=0;n<length;n++){
	file = dir + files[n];
	open(file);
	rename("new_stack");
	title = "offset=" + offset;
	title_stack = "stack=" + offset;
	if (offset == 0){
		rename(title_stack);
	}
	if (offset > 0){
		rename(title);
		run("Concatenate...", "  image1=title image2=title_stack image3=[-- None --]");
	}
	rename("stack=" + offset+1);
	close("new_stack");
	close(title);
	close(title_stack);
	offset += 1;
}

//Get image dimensions
w = getWidth();
h = getHeight();

waitForUser("Progress","Done");