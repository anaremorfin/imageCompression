%Image Compression

%compimag('lena', 'tiff', 10)
compimag('lena', 'tiff', 25)
%compimag('lena', 'tiff', 50)
%compimag('lena', 'tiff', 75)

function compimag (nomarch, tipo, umbral)
%Open file
originalimage = imread(nomarch, tipo);
% B&W
bwimage = im2gray(originalimage);
%Display b&w image
subplot(1, 2, 1), imshow(bwimage), title("Original");
%Entropy from b&w image
entropyOriginalImaginal = entropy(bwimage)
%8x8 Division & DCT
FUN1 = @(block_struct) dct2(block_struct.data);
transfimage = blockproc(bwimage, [8 8], FUN1);
%Normal 
MMAX = max(max(abs(transfimage)));
aux = (transfimage./MMAX).*255;
max(max(abs(aux)));
aux2 = round(aux);
max(max(abs(aux2)));
%Mask 
mask = abs(aux2) > umbral;
filteredimage = (mask.*transfimage);
entropyFilteredMatrix = entropy(filteredimage)
%Inverse DCT
FUN2 = @(block_struct) idct2(block_struct.data);
restoredimage = blockproc(filteredimage, [8 8], FUN2);
%Show restored image
%imshow(uint8(restoredimage))
%subplot(1, 2, 2), imshow(uint8(restoredimage)), title("Compresión");
%Average Power
power =  sum(sum(restoredimage.^2))/numel(restoredimage);
%Mean Squared Error
ECM = immse(bwimage, uint8(restoredimage));
%Error
Error = ECM/power*100
%Compression
notZero = nnz(uint8(restoredimage));
pixels = numel(bwimage);
compressionPercentage = (1-notZero/pixels)*100
subplot(1, 2, 2), imshow(uint8(restoredimage)), title("Umbral:"+umbral+" Err: "+Error+" Comp: "+compressionPercentage+"%");
%Average Power
end 
