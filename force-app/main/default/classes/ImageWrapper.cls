public class ImageWrapper {
    @AuraEnabled
    public String imageUrl { get; set; }

    public ImageWrapper(String url) {
        this.imageUrl = url;
    }
}