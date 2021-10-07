def get_list(image):
    import numpy as np
    from PIL import Image

    img = Image.open(image)
    img = img.resize((28,28))
    pix = np.array(img)
    #pix = pix[:,:,3]
    pix = pix / 255.
    pix = np.expand_dims(pix, 2)
    pix = np.expand_dims(pix, 0)
    pix = np.expand_dims(pix, 3)
    pix_list = pix.tolist()
    
    return pix_list
