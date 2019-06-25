public class kkk {
    public static void main(String[] args) {
        int[] a={1,2,2,1};
        int len=4;
        int s=0;
        for(int i=0;i<len/2;i++){
            System.out.println(a[i]);
            s=i;
            System.out.println("s:"+s);
        }
        if(len%2!=0) s=s+1;
        System.out.println("ss:"+s);
        for (int j=s;j<len;j++){
            int i=0;
            if(a[j]==a[i]){
                System.out.println("false");
            }
            i+=1;
        }
        System.out.println("true");
    }
}
