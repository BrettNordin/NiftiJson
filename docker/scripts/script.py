import sys
import json
import SimpleITK as sitk
reader = sitk.ImageFileReader()
location = sys.argv[1]
reader.SetFileName(location)
reader.LoadPrivateTagsOn()
reader.ReadImageInformation()
data_dictionary = {}
for k in reader.GetMetaDataKeys():
    v = reader.GetMetaData(k)
    data_dictionary[k] = v
f = open(location.replace(".nii.gz",".json"), "a")
f.write(json.dumps(data_dictionary))
f.close()
